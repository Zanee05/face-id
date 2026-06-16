<?php

namespace App\Traits;

trait FaceRecognitionTrait
{
    /**
     * Threshold jarak maksimal untuk dianggap "cocok".
     * Dinaikkan ke 0.80 agar confidence lebih tinggi dengan formula cosine.
     */
    protected function getThreshold(): float
    {
        return (float) env('FACE_DISTANCE_THRESHOLD', 0.80);
    }

    /**
     * Confidence minimum yang harus dicapai agar absensi diterima.
     */
    protected function getMinConfidence(): float
    {
        return (float) env('MIN_CONFIDENCE_THRESHOLD', 80.0);
    }

    /**
     * Batas keras (hard limit) jarak absolut — TERLEPAS dari threshold dan confidence.
     * Jika distance melebihi nilai ini, SELALU ditolak meskipun confidence tinggi.
     *
     * Ini adalah lapisan keamanan kedua untuk mencegah wajah mirip lolos.
     * Nilai 0.45 = batas aman berdasarkan karakteristik normalized euclidean distance:
     *   - Wajah sama orang:    biasanya 0.05 – 0.35
     *   - Wajah mirip/saudara: biasanya 0.35 – 0.50
     *   - Wajah berbeda:       biasanya 0.50 – 1.40
     */
    protected function getHardDistanceLimit(): float
    {
        return (float) env('FACE_HARD_DISTANCE_LIMIT', 0.45);
    }

    protected function normalizeEmbedding(array $embedding): array
    {
        $sumSquares = 0.0;
        foreach ($embedding as $value) {
            $sumSquares += (float) $value * (float) $value;
        }

        $magnitude = sqrt($sumSquares);

        if ($magnitude < 1e-10) {
            return $embedding;
        }

        return array_map(fn($v) => (float) $v / $magnitude, $embedding);
    }

    protected function calculateDistance(array $embeddingA, array $embeddingB): float
    {
        if (count($embeddingA) !== count($embeddingB) || empty($embeddingA)) {
            return INF;
        }

        $normA = $this->normalizeEmbedding(array_values($embeddingA));
        $normB = $this->normalizeEmbedding(array_values($embeddingB));

        $sum = 0.0;
        $len = count($normA);
        for ($i = 0; $i < $len; $i++) {
            $delta = $normA[$i] - $normB[$i];
            $sum  += $delta * $delta;
        }

        return sqrt($sum);
    }

    /**
     * Hitung confidence menggunakan cosine mapping dengan threshold 0.80.
     *
     * Formula: cos(distance/threshold × π/2) × 100
     *
     * Contoh (threshold=0.80):
     *   distance 0.10 →  98.1%
     *   distance 0.20 →  92.4%
     *   distance 0.25 →  88.2%
     *   distance 0.30 →  83.1%
     *   distance 0.35 →  77.3%
     *   distance 0.45 →  55.6%  ← hard limit, tidak akan lolos
     *   distance 0.80 →   0.0%
     */
    protected function calculateConfidence(float $distance, float $threshold): float
    {
        if ($threshold <= 0.0 || !is_finite($distance)) {
            return 0.0;
        }

        if ($distance <= 0.0) {
            return 100.0;
        }

        $ratio = min($distance / $threshold, 1.0);
        $score = cos($ratio * (M_PI / 2.0)) * 100.0;

        return max(0.0, min(100.0, round($score, 2)));
    }

    protected function isConfidenceSufficient(float $confidence): bool
    {
        return $confidence >= $this->getMinConfidence();
    }

    /**
     * Validasi pengenalan wajah dengan 3 lapis pemeriksaan:
     *
     * Lapis 1 — Hard Distance Limit (keamanan absolut)
     *   Jika distance > 0.45, TOLAK tanpa melihat confidence.
     *   Ini mencegah wajah mirip/saudara lolos meskipun confidence tinggi.
     *
     * Lapis 2 — Threshold Check
     *   Jika distance >= threshold (0.80), TOLAK.
     *   Ini batas normal sistem.
     *
     * Lapis 3 — Confidence Check
     *   Jika confidence < 80%, TOLAK.
     *   Ini memastikan kualitas pencocokan cukup baik.
     */
    protected function validateFaceRecognition(float $distance, float $confidence): array
    {
        $threshold      = $this->getThreshold();
        $minConfidence  = $this->getMinConfidence();
        $hardLimit      = $this->getHardDistanceLimit();

        // Lapis 1: Hard distance limit — blokir wajah mirip
        if ($distance > $hardLimit) {
            return [
                'valid'  => false,
                'reason' => 'Wajah tidak cocok.',
                'code'   => 'HARD_LIMIT_EXCEEDED',
            ];
        }

        // Lapis 2: Threshold normal
        if ($distance >= $threshold) {
            return [
                'valid'  => false,
                'reason' => 'Wajah tidak cocok.',
                'code'   => 'FACE_MISMATCH',
            ];
        }

        // Lapis 3: Confidence minimum
        if ($confidence < $minConfidence) {
            return [
                'valid'  => false,
                'reason' => "Confidence terlalu rendah ({$confidence}%, minimum {$minConfidence}%).",
                'code'   => 'LOW_CONFIDENCE',
            ];
        }

        return [
            'valid'  => true,
            'reason' => 'Wajah cocok.',
            'code'   => 'SUCCESS',
        ];
    }
}

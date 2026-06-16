<?php

namespace App\Console\Commands;

use App\Models\FaceData;
use App\Traits\FaceRecognitionTrait;
use Illuminate\Console\Command;

class NormalizeFaceEmbeddings extends Command
{
    use FaceRecognitionTrait;

    protected $signature = 'face:normalize-embeddings 
                            {--dry-run : Show what would be normalized without actually doing it}
                            {--force : Force normalization even if already normalized}';

    protected $description = 'Normalize all existing face embeddings for better accuracy';

    public function handle()
    {
        $this->info('=== Face Embeddings Normalization ===');
        $this->newLine();

        $dryRun = $this->option('dry-run');
        $force = $this->option('force');

        if ($dryRun) {
            $this->warn('DRY RUN MODE - No changes will be made');
            $this->newLine();
        }

        $faceDataRecords = FaceData::all();

        if ($faceDataRecords->isEmpty()) {
            $this->warn('No face data found in database.');
            return Command::SUCCESS;
        }

        $this->info("Found {$faceDataRecords->count()} face data records.");
        $this->newLine();

        $normalized = 0;
        $skipped = 0;
        $errors = 0;

        $progressBar = $this->output->createProgressBar($faceDataRecords->count());
        $progressBar->start();

        foreach ($faceDataRecords as $faceData) {
            try {
                $embedding = $faceData->embedding;

                if (!is_array($embedding) || count($embedding) !== 128) {
                    $this->newLine();
                    $this->error("Invalid embedding for user_id: {$faceData->user_id}");
                    $errors++;
                    $progressBar->advance();
                    continue;
                }

                // Check if already normalized
                $magnitude = $this->calculateMagnitude($embedding);
                $isNormalized = abs($magnitude - 1.0) < 0.01; // tolerance 1%

                if ($isNormalized && !$force) {
                    $skipped++;
                    $progressBar->advance();
                    continue;
                }

                // Normalize
                $normalizedEmbedding = $this->normalizeEmbedding($embedding);

                if (!$dryRun) {
                    $faceData->embedding = $normalizedEmbedding;
                    $faceData->save();
                }

                $normalized++;
            } catch (\Exception $e) {
                $this->newLine();
                $this->error("Error processing user_id {$faceData->user_id}: {$e->getMessage()}");
                $errors++;
            }

            $progressBar->advance();
        }

        $progressBar->finish();
        $this->newLine(2);

        // Summary
        $this->info('=== Summary ===');
        $this->table(
            ['Status', 'Count'],
            [
                ['Normalized', $normalized],
                ['Skipped (already normalized)', $skipped],
                ['Errors', $errors],
                ['Total', $faceDataRecords->count()],
            ]
        );

        if ($dryRun) {
            $this->newLine();
            $this->warn('This was a DRY RUN. No changes were made.');
            $this->info('Run without --dry-run to apply changes.');
        } else {
            $this->newLine();
            $this->info('✅ Normalization completed!');
            $this->info('All users should re-register their faces for best results.');
        }

        return Command::SUCCESS;
    }

    private function calculateMagnitude(array $embedding): float
    {
        $sumSquares = 0.0;
        foreach ($embedding as $value) {
            $sumSquares += $value * $value;
        }
        return sqrt($sumSquares);
    }
}

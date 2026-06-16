# Diagram SIAKAD - Absensi Face ID

## Cara Membuka di draw.io

1. Buka https://app.diagrams.net/
2. Klik **Extras** → **Edit Diagram**
3. Copy-paste isi file `.puml`
4. Klik **OK**

Atau:
1. Buka https://www.plantuml.com/plantuml/uml/
2. Paste isi file `.puml`
3. Klik **Submit**

---

## Daftar Diagram

| File | Judul | Keterangan |
|------|-------|------------|
| `01_arsitektur_sistem.puml` | Arsitektur Sistem | Gambaran lengkap semua layer: Client, Middleware, Controller, Model, Database |
| `02_flowchart_face_id.puml` | Flowchart Absensi Face ID | Alur lengkap proses scan wajah di kiosk mode |
| `03_flowchart_registrasi_wajah.puml` | Flowchart Registrasi Wajah | Alur registrasi 5 foto multi-angle |
| `04_pipeline_ml.puml` | Pipeline Machine Learning | 5 stage: Detection → Landmark → Descriptor → Normalization → Matching |
| `05_sequence_absensi.puml` | Sequence Diagram | Interaksi antar komponen saat absensi |
| `06_usecase_faceid.puml` | Use Case Diagram | Fokus Face ID (tanpa absensi manual) |
| `07_database_erd.puml` | ERD Database | Semua tabel dan relasi |

---

## Ringkasan Arsitektur

```
Browser (Client)
├── face-api.js (TensorFlow.js)
│   ├── TinyFaceDetector (deteksi wajah)
│   ├── FaceLandmark68Net (68 titik landmark)
│   └── FaceRecognitionNet (128-dim embedding)
├── Offscreen Canvas (fix DroidCam)
└── Blade UI (Bootstrap 5)

Laravel Backend
├── Middleware: Auth + RoleMiddleware
├── Controllers: Admin / Dosen / Mahasiswa
├── Trait: FaceRecognitionTrait
│   ├── normalizeEmbedding() - L2 normalization
│   ├── calculateDistance() - Euclidean distance
│   ├── calculateConfidence() - Cosine mapping
│   └── validateFaceRecognition() - Threshold check
└── Models: Eloquent ORM

MySQL Database
├── face_data (embedding 128-dim JSON)
├── absensi (confidence, metode, status)
├── face_logs (distance, confidence, status)
└── activity_logs (audit trail)
```

## Parameter Kunci

| Parameter | Nilai | Keterangan |
|-----------|-------|------------|
| `FACE_DISTANCE_THRESHOLD` | 0.60 | Batas maksimal euclidean distance |
| `MIN_CONFIDENCE_THRESHOLD` | 80.0% | Confidence minimum untuk absensi |
| `inputSize` | 416 | Resolusi input face detector |
| `scoreThreshold` | 0.35 | Sensitivitas deteksi wajah |
| `SCAN_INTERVAL_MS` | 1000ms | Interval auto scan kiosk |
| `RECOGNIZE_COOLDOWN_MS` | 4000ms | Jeda antar scan per wajah |
| Embedding dimension | 128 | Ukuran vektor wajah |
| Foto registrasi | 5 angle | Depan, Kiri, Kanan, Atas, Bawah |

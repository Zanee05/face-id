@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-4">Dashboard SIAKAD</h4>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6>Total Mahasiswa</h6>
                    <h3>{{ $totalMahasiswa }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6>Total Dosen</h6>
                    <h3>{{ $totalDosen }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6>Hadir Hari Ini</h6>
                    <h3>{{ $totalHadirHariIni }}</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <h6 class="mb-3">Grafik Kehadiran Bulanan</h6>
            <canvas id="chartAbsensi" height="90"></canvas>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const labels = @json($rekapBulanan->pluck('bulan'));
const values = @json($rekapBulanan->pluck('total'));
new Chart(document.getElementById('chartAbsensi'), {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Total Hadir',
            data: values,
            backgroundColor: '#0d6efd'
        }]
    }
});
</script>
@endsection

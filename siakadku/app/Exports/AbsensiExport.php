<?php

namespace App\Exports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class AbsensiExport implements FromCollection, WithHeadings, WithMapping
{
    /**
     * @var \Illuminate\Support\Collection<int, \App\Models\Absensi>
     */
    private Collection $rows;

    /**
     * @param \Illuminate\Support\Collection<int, \App\Models\Absensi> $rows
     */
    public function __construct(Collection $rows)
    {
        $this->rows = $rows;
    }

    public function collection(): Collection
    {
        return $this->rows;
    }

    /**
     * @param \App\Models\Absensi $item
     * @return array<int, mixed>
     */
    public function map($item): array
    {
        return [
            optional($item->mahasiswa)->nim,
            optional($item->mahasiswa)->nama,
            (string) $item->tanggal,
            strtoupper((string) $item->status),
            strtoupper((string) $item->metode),
            $item->confidence !== null ? $item->confidence : '-',
        ];
    }

    /**
     * @return array<int, string>
     */
    public function headings(): array
    {
        return ['NIM', 'Nama', 'Tanggal', 'Status', 'Metode', 'Confidence'];
    }
}


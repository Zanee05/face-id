<?php

namespace App\Console\Commands;

use App\Traits\FaceRecognitionTrait;
use Illuminate\Console\Command;

class TestFaceRecognitionConfig extends Command
{
    use FaceRecognitionTrait;

    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'face:test-config 
                            {--distance= : Test distance value}
                            {--show-examples : Show example calculations}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Test and validate face recognition configuration';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('=== Face Recognition Configuration Test ===');
        $this->newLine();

        // Show current configuration
        $this->showCurrentConfig();
        $this->newLine();

        // Validate configuration
        $this->validateConfig();
        $this->newLine();

        // Show examples if requested
        if ($this->option('show-examples')) {
            $this->showExamples();
            $this->newLine();
        }

        // Test specific distance if provided
        if ($distance = $this->option('distance')) {
            $this->testDistance((float) $distance);
            $this->newLine();
        }

        $this->info('✅ Configuration test completed!');

        return Command::SUCCESS;
    }

    /**
     * Show current configuration
     */
    private function showCurrentConfig()
    {
        $threshold = $this->getThreshold();
        $minConfidence = $this->getMinConfidence();

        $this->info('Current Configuration:');
        $this->table(
            ['Setting', 'Value', 'Source'],
            [
                ['FACE_DISTANCE_THRESHOLD', $threshold, env('FACE_DISTANCE_THRESHOLD') ? '.env' : 'default'],
                ['MIN_CONFIDENCE_THRESHOLD', $minConfidence . '%', env('MIN_CONFIDENCE_THRESHOLD') ? '.env' : 'default'],
            ]
        );
    }

    /**
     * Validate configuration values
     */
    private function validateConfig()
    {
        $threshold = $this->getThreshold();
        $minConfidence = $this->getMinConfidence();
        $issues = [];

        $this->info('Configuration Validation:');

        // Validate threshold
        if ($threshold <= 0 || $threshold > 1.0) {
            $issues[] = '❌ FACE_DISTANCE_THRESHOLD must be between 0 and 1.0';
        } else if ($threshold < 0.3) {
            $this->warn('⚠️  FACE_DISTANCE_THRESHOLD is very strict (< 0.3). May cause many false rejections.');
        } else if ($threshold > 0.6) {
            $this->warn('⚠️  FACE_DISTANCE_THRESHOLD is very loose (> 0.6). May cause false acceptances.');
        } else {
            $this->line('✅ FACE_DISTANCE_THRESHOLD is within recommended range (0.3 - 0.6)');
        }

        // Validate min confidence
        if ($minConfidence < 0 || $minConfidence > 100) {
            $issues[] = '❌ MIN_CONFIDENCE_THRESHOLD must be between 0 and 100';
        } else if ($minConfidence < 70) {
            $this->warn('⚠️  MIN_CONFIDENCE_THRESHOLD is low (< 70%). Security may be compromised.');
        } else if ($minConfidence > 95) {
            $this->warn('⚠️  MIN_CONFIDENCE_THRESHOLD is very high (> 95%). May cause many false rejections.');
        } else {
            $this->line('✅ MIN_CONFIDENCE_THRESHOLD is within recommended range (70% - 95%)');
        }

        // Show critical issues
        if (!empty($issues)) {
            $this->newLine();
            $this->error('Critical Issues Found:');
            foreach ($issues as $issue) {
                $this->error($issue);
            }
        }
    }

    /**
     * Show example calculations
     */
    private function showExamples()
    {
        $threshold = $this->getThreshold();
        $minConfidence = $this->getMinConfidence();

        $this->info('Example Calculations:');
        
        $examples = [
            ['Distance', 'Confidence', 'Status', 'Description'],
        ];

        $testDistances = [
            0.00 => 'Perfect match',
            0.05 => 'Excellent match',
            0.09 => 'Good match (80% threshold)',
            0.15 => 'Fair match',
            0.20 => 'Marginal match',
            0.30 => 'Poor match',
            $threshold => 'At threshold',
            $threshold + 0.05 => 'Above threshold',
        ];

        foreach ($testDistances as $distance => $description) {
            $confidence = $this->calculateConfidence($distance, $threshold);
            $validation = $this->validateFaceRecognition($distance, $confidence);
            
            $status = $validation['valid'] ? '✅ Accept' : '❌ Reject';
            if (!$validation['valid']) {
                $status .= ' (' . $validation['code'] . ')';
            }

            $examples[] = [
                number_format($distance, 4),
                number_format($confidence, 2) . '%',
                $status,
                $description,
            ];
        }

        $this->table(['Distance', 'Confidence', 'Status', 'Description'], $examples);

        $this->newLine();
        $this->info('Legend:');
        $this->line('  ✅ Accept: Face recognition successful, attendance will be recorded');
        $this->line('  ❌ Reject: Face recognition failed, attendance will be rejected');
        $this->line('  FACE_MISMATCH: Distance exceeds threshold');
        $this->line('  LOW_CONFIDENCE: Confidence below minimum threshold');
    }

    /**
     * Test specific distance value
     */
    private function testDistance(float $distance)
    {
        $threshold = $this->getThreshold();
        $confidence = $this->calculateConfidence($distance, $threshold);
        $validation = $this->validateFaceRecognition($distance, $confidence);

        $this->info("Testing Distance: {$distance}");
        $this->newLine();

        $this->table(
            ['Metric', 'Value'],
            [
                ['Input Distance', number_format($distance, 4)],
                ['Calculated Confidence', number_format($confidence, 2) . '%'],
                ['Threshold', number_format($threshold, 4)],
                ['Min Confidence Required', $this->getMinConfidence() . '%'],
                ['Validation Result', $validation['valid'] ? '✅ VALID' : '❌ INVALID'],
                ['Reason', $validation['reason']],
                ['Code', $validation['code']],
            ]
        );

        if ($validation['valid']) {
            $this->info('✅ This face would be accepted for attendance.');
        } else {
            $this->error('❌ This face would be rejected for attendance.');
            $this->line('Reason: ' . $validation['reason']);
        }
    }
}

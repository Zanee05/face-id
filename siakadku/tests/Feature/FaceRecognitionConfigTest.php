<?php

namespace Tests\Feature;

use App\Traits\FaceRecognitionTrait;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FaceRecognitionConfigTest extends TestCase
{
    use FaceRecognitionTrait;

    /**
     * Test default threshold value
     *
     * @return void
     */
    public function test_default_threshold_value()
    {
        $threshold = $this->getThreshold();
        
        $this->assertIsFloat($threshold);
        $this->assertGreaterThan(0, $threshold);
        $this->assertLessThanOrEqual(1.0, $threshold);
    }

    /**
     * Test default min confidence value
     *
     * @return void
     */
    public function test_default_min_confidence_value()
    {
        $minConfidence = $this->getMinConfidence();
        
        $this->assertIsFloat($minConfidence);
        $this->assertGreaterThanOrEqual(0, $minConfidence);
        $this->assertLessThanOrEqual(100, $minConfidence);
    }

    /**
     * Test distance calculation
     *
     * @return void
     */
    public function test_distance_calculation()
    {
        // Identical embeddings should have distance 0
        $embedding1 = array_fill(0, 128, 0.5);
        $embedding2 = array_fill(0, 128, 0.5);
        
        $distance = $this->calculateDistance($embedding1, $embedding2);
        
        $this->assertEquals(0, $distance);
    }

    /**
     * Test distance calculation with different embeddings
     *
     * @return void
     */
    public function test_distance_calculation_different_embeddings()
    {
        $embedding1 = array_fill(0, 128, 0.5);
        $embedding2 = array_fill(0, 128, 0.6);
        
        $distance = $this->calculateDistance($embedding1, $embedding2);
        
        $this->assertGreaterThan(0, $distance);
    }

    /**
     * Test confidence calculation
     *
     * @return void
     */
    public function test_confidence_calculation()
    {
        $threshold = 0.45;
        
        // Distance 0 should give 100% confidence
        $confidence = $this->calculateConfidence(0, $threshold);
        $this->assertEquals(100, $confidence);
        
        // Distance equal to threshold should give 0% confidence
        $confidence = $this->calculateConfidence($threshold, $threshold);
        $this->assertEquals(0, $confidence);
        
        // Distance at half threshold should give 50% confidence
        $confidence = $this->calculateConfidence($threshold / 2, $threshold);
        $this->assertEquals(50, $confidence);
    }

    /**
     * Test confidence validation
     *
     * @return void
     */
    public function test_confidence_validation()
    {
        // Test with sufficient confidence
        $result = $this->isConfidenceSufficient(85.0);
        $this->assertTrue($result);
        
        // Test with insufficient confidence
        $result = $this->isConfidenceSufficient(75.0);
        $this->assertFalse($result);
    }

    /**
     * Test face recognition validation - success case
     *
     * @return void
     */
    public function test_face_recognition_validation_success()
    {
        $distance = 0.05; // Very small distance
        $confidence = 88.89; // High confidence
        
        $result = $this->validateFaceRecognition($distance, $confidence);
        
        $this->assertTrue($result['valid']);
        $this->assertEquals('SUCCESS', $result['code']);
    }

    /**
     * Test face recognition validation - face mismatch
     *
     * @return void
     */
    public function test_face_recognition_validation_mismatch()
    {
        $distance = 0.50; // Distance above threshold
        $confidence = 0; // Low confidence
        
        $result = $this->validateFaceRecognition($distance, $confidence);
        
        $this->assertFalse($result['valid']);
        $this->assertEquals('FACE_MISMATCH', $result['code']);
    }

    /**
     * Test face recognition validation - low confidence
     *
     * @return void
     */
    public function test_face_recognition_validation_low_confidence()
    {
        $distance = 0.10; // Distance below threshold
        $confidence = 75.0; // Below minimum confidence (80%)
        
        $result = $this->validateFaceRecognition($distance, $confidence);
        
        $this->assertFalse($result['valid']);
        $this->assertEquals('LOW_CONFIDENCE', $result['code']);
    }

    /**
     * Test edge case: empty embeddings
     *
     * @return void
     */
    public function test_distance_calculation_empty_embeddings()
    {
        $embedding1 = [];
        $embedding2 = [];
        
        $distance = $this->calculateDistance($embedding1, $embedding2);
        
        $this->assertEquals(INF, $distance);
    }

    /**
     * Test edge case: mismatched embedding sizes
     *
     * @return void
     */
    public function test_distance_calculation_mismatched_sizes()
    {
        $embedding1 = array_fill(0, 128, 0.5);
        $embedding2 = array_fill(0, 64, 0.5);
        
        $distance = $this->calculateDistance($embedding1, $embedding2);
        
        $this->assertEquals(INF, $distance);
    }

    /**
     * Test confidence bounds
     *
     * @return void
     */
    public function test_confidence_bounds()
    {
        $threshold = 0.45;
        
        // Test negative distance (should be clamped to 100%)
        $confidence = $this->calculateConfidence(-0.1, $threshold);
        $this->assertEquals(100, $confidence);
        
        // Test very large distance (should be clamped to 0%)
        $confidence = $this->calculateConfidence(10.0, $threshold);
        $this->assertEquals(0, $confidence);
    }

    /**
     * Test realistic scenario: good match
     *
     * @return void
     */
    public function test_realistic_good_match()
    {
        $threshold = 0.45;
        $distance = 0.09; // Just at the edge for 80% confidence
        
        $confidence = $this->calculateConfidence($distance, $threshold);
        
        $this->assertEquals(80, $confidence);
        $this->assertTrue($this->isConfidenceSufficient($confidence));
    }

    /**
     * Test realistic scenario: poor match
     *
     * @return void
     */
    public function test_realistic_poor_match()
    {
        $threshold = 0.45;
        $distance = 0.40; // Close to threshold
        
        $confidence = $this->calculateConfidence($distance, $threshold);
        
        $this->assertLessThan(20, $confidence);
        $this->assertFalse($this->isConfidenceSufficient($confidence));
    }
}

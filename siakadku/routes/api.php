<?php

use App\Http\Controllers\Api\FaceRecognitionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/face/register', [FaceRecognitionController::class, 'register']);
    Route::post('/face/verify-attendance', [FaceRecognitionController::class, 'verifyAndAttend']);
    Route::post('/face/sessions/{session}/verify', [FaceRecognitionController::class, 'verifySessionFace']);
    Route::post('/attendance/scan-barcode', [FaceRecognitionController::class, 'scanBarcode']);
});

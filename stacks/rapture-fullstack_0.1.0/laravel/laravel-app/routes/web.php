<?php

use App\Http\Controllers\ContactUsFormController;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Route;
use App\Models\Enquire;


Route::get('/', function () {
    return view('enquiries', [ #PASS COLLECTIONS TO THE VIEW
        'enquiries' => Enquire::all()
    ]);
});

Route::get('/about', function () {
    return view('about');
});

Route::get('/pricing', function () {
    return view('pricing');
});

# ENQUIRIES/<WILDCARD>, PASS FUNCTION $SLUG
Route::get('enquiries/{enquire}', function ($slug) {
    return view('enquire', [ # Find 'enquire'
        'enquire' => Enquire::findOrFail($slug) # Pass it to the view (What the user sees)
    ]);
});

Route::post('enquiries/{enquire}', [ContactUsFormController::class, 'ContactUsForm'])->name('contact.store');

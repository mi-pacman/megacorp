<?php

namespace App\Models;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\File;
use Spatie\YamlFrontMatter\YamlFrontMatter;
use function Symfony\Component\Finder\sortByName;

# IMPORTS FILE FUNCTION - GIVES STATIC ACCESS TO VARIOUS FUNCTIONALITY

class Enquire
{
    public $title;
    public $excerpt;
    public $image;
    public $body;
    public $slug;
    public $num;

    public function __construct($title, $excerpt, $image, $body, $slug, $num)
    {
        $this->title = $title;
        $this->excerpt = $excerpt;
        $this->image = $image;
        $this->body = $body;
        $this->slug = $slug;
        $this->num = $num;
    }


    public static function all() # GETS ALL PAGES CREATED
    {
        return cache()->rememberForever('posts.all', function () { #CACHE ALL PAGES
            return collect(File::files(resource_path("enquiries/"))) #FIND ALL FILES IN DIRECTORY & ADD TO COLLECTION
            ->map(fn($file) => YamlFrontMatter::parseFile($file)) #ONCE LOOPED OVER PARSE EACH FILE IN A DOCUMENT
            ->map(fn($document) => new Enquire( #ONCE COLLECTED MAP OVER A SECOND TIME
                $document->title,
                $document->excerpt,
                $document->image,
                $document->body(),
                $document->slug,
                $document->num
            ))
                ->sortBy('num');
        });
    }

    public static function find($slug) //FIND SLUG THAT WAS REQUESTED
    {
        return static::all()->firstWhere('slug', $slug);
    }

    public static function findOrFail($slug) //FIND SLUG THAT WAS REQUESTED
    {
        $enquire = static::find($slug);

        if(!$enquire) {
            throw new ModelNotFoundException(); //IF PAGE NOT FOUND THROW 404
        }

        return $enquire; //SHOW PAGE IF FOUND
    }
}

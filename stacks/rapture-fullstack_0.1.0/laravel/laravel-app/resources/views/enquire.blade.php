@extends('layout')

@section('content')
    <section class="container p-5 my-5 text-white bg-dark border-gradient">
        <h1 class="mb-4">{{ $enquire->title }}</h1>
        {!! $enquire->body !!}
    </section>
@endsection

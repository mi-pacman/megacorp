@extends('layout')

@section('content')
    <section class="container p-5 my-5 text-white bg-dark border-gradient">
        <h1 class="mb-4">Lorem ipsum dolor sit amet</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin volutpat nisi vel eros scelerisque consequat. Proin leo lectus, iaculis eu velit sed, accumsan hendrerit odio. Vestibulum porttitor dolor non neque imperdiet, sit amet commodo diam viverra. Duis auctor orci sit amet scelerisque scelerisque. Nam tempus at est nec mollis. Cras sit amet ultrices leo. Suspendisse tempor ultricies justo, a malesuada enim pellentesque id.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin volutpat nisi vel eros scelerisque consequat. Proin leo lectus, iaculis eu velit sed, accumsan hendrerit odio. Vestibulum porttitor dolor non neque imperdiet, sit amet commodo diam viverra. Duis auctor orci sit amet scelerisque scelerisque. Nam tempus at est nec mollis. Cras sit amet ultrices leo. Suspendisse tempor ultricies justo, a malesuada enim pellentesque id.</p>
    </section>

    <section class="container my-5 text-white">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        @foreach ($enquiries as $enquire) {{--BLADE DIRECTIVE--}}
            <div class="col">
                <div class="card-body shadow-sm bg-dark">
                    <img style="object-fit: cover; object-position: top" class="bd-placeholder-img card-img-top" src="<?= $enquire->image; ?>" height="200">

                    <div class="card-body bg-dark">
                        <h4 class="card-text"><?= $enquire->title; ?></h4>
                        <p class="card-text"><?= $enquire->excerpt; ?></p>

                        <div class="d-grid gap-2">
                            <button onclick="window.location.href='/enquiries/{{ $enquire->slug }}';"  type="button" class="btn-lg btn btn-info"><b>Enquire</b></button>
                        </div>
                    </div>
                </div>
            </div>
        @endforeach
        </div>
    </section>
@endsection

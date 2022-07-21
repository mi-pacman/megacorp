@extends('layout')

@section('content')
    <section class="container p-5 my-5 text-white bg-dark border-gradient">
        <div class="container pb-5">
            <div class="row">
                <div class="col-md-12 text-center">
                        <h2 editable="inline" class="display-2 mb-4"><b>Pricing</b></h2>
                        <p editable="inline"> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc et metus id<br> ligula malesuada placerat sit amet quis enim.</p>
                    </div>
                </div>
            </div>
            <div class="row mt-4 text-center">
                <div class="col-lg-4 col-md-6 text-white my-2">
                    <div class="card bg-dark">
                        <div class="card-header">
                            <h4 class="my-0 " editable="inline">Phones</h4>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><span class="display-4" editable="inline"><span editable="inline" class="lead">from </span><b>$200</b></span></h5>
                            <div class="card-text my-4 lc-block">
                                <div editable="rich">
                                    <ul class="list-unstyled">
                                        <li editable="inline">Graphene OS</li>
                                        <li editable="inline">24/7 remote support</li>
                                        <li editable="inline">Complete anonymity</li>
                                        <li editable="inline">Wide selection of devices</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="d-grid lc-block">
                                <a onclick="window.location.href='/enquiries/phones';" class="btn btn-lg btn-info"><b>Contact us</b></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 text-white my-2">
                    <div class="card bg-dark">
                        <div class="card-header">
                            <h4 class="my-0" editable="inline">Computers</h4>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><span class="display-4" editable="inline"><span editable="inline" class="lead">from </span><b>$400</b></span></h5>
                            <div class="card-text my-4 lc-block">
                                <div editable="rich">
                                    <ul class="list-unstyled">
                                        <li editable="inline" class="">Complete anonymity</li>
                                        <li editable="inline" class="">24/7 remote support</li>
                                        <li editable="inline" class="">Prepared to meet your needs</li>
                                        <li editable="inline" class="">Business solutions</li>
                                    </ul>

                                </div>
                            </div>
                            <div class="d-grid lc-block">
                                <a onclick="window.location.href='/enquiries/computers';" class="btn btn-lg btn-info"><b>Contact us</b></a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 text-white my-2">
                    <div class="card bg-dark">
                        <div class="card-header">
                            <h4 class="my-0" editable="inline">Other Solutions</h4>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><span class="display-4" editable="inline"><b>Negotiable</b></span></h5>
                            <div class="card-text my-4 lc-block">
                                <div editable="rich">
                                    <ul class="list-unstyled">
                                        <li editable="inline" class="">Opsec solutions</li>
                                        <li editable="inline" class="">Business solutions</li>
                                        <li editable="inline" class="">Network infrastructure</li>
                                        <li editable="inline" class="">A wide range of solutions</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="d-grid lc-block">
                                <a onclick="window.location.href='/enquiries/other';" class="btn btn-lg btn-info"><b>Contact us</b></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
@endsection

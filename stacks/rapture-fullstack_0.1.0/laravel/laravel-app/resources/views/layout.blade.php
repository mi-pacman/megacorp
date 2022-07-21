<!-- | BLUE = #00e3ef | PINK = #d21cea | -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TECH JUNKIES</title>
    <!-- Linking Bootstrap CSS Library -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- JavaScript Bundle With Popper - This Is Required For Bootstrap Features -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif&family=Roboto+Mono&display=swap" rel="stylesheet">
    <!-- Some styling -->
    <style>
        .navbar-dark{
            background: black;
            border-bottom: 2px solid #d21cea;
        }

        .nav-link{
            color: #00e3ef !important;
        }

        .bg-dark{
            background-color: black !important;
        }

        .border-gradient {
            border: 10px solid;
            border-image-slice: 1;
            border-image-source: linear-gradient(307deg, #00e3ef, #d21cea);
        }
    </style>
</head>
<body style="background-attachment: fixed; background-image: url('https://i.lensdump.com/i/tZEYNH.jpg'); background-size: cover; background-color: black; font-family: 'Roboto Mono', monospace;">

<!-- Navigation bar code -->
<nav class="navbar sticky-top navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <!-- Website logo -->
        <a class="navbar-brand" href="/">
            <img src="https://i.lensdump.com/i/rnYgKk.png" alt="" width="190" height="24">
        </a>
        <!-- Code to make nav bar collapsable -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Nav bar links -->
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link me-2" href="/"><b>HOMEPAGE</b></a>
                <a class="nav-link me-2" href="/about"><b>ABOUT US</b></a>
                <a class="nav-link me-2" href="/pricing"><b>PRODUCT PRICING</b></a>
            </div>
        </div>
    </div>
</nav>

<main>
    @yield('content') <!-- Grabs the content of the page requested -->

    @if(session()->has('success')) <!-- If form is successful show message -->
        <div class="alert alert-primary">
            {{ session()->get('success') }}
        </div>
    @endif
</main>

</body>
</html>

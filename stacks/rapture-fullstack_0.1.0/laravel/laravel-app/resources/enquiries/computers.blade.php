---
title: PC Solutions
excerpt: Contact us about our private and secure computer solutions for whatever use case is needed.
image: https://i3.lensdump.com/i/rXszM3.png
slug: computers
num: 1
---

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin volutpat nisi vel eros scelerisque consequat. Proin leo lectus, iaculis eu velit sed, accumsan hendrerit odio. Vestibulum porttitor dolor non neque imperdiet, sit amet commodo diam viverra. Duis auctor orci sit amet scelerisque scelerisque. Nam tempus at est nec mollis. Cras sit amet ultrices leo. Suspendisse tempor ultricies justo, a malesuada enim pellentesque id.</p>

<form method="post" action="{{ route('contact.store') }}">
    <div class="row">
        <div class="col-md-5">
            <label for="selection" class="col-form-label">Choose computer</label>
            <select name="selection" id="selection" class="form-select">
                <option value="Laptop">Laptop</option>
                <option value="Desktop">Desktop</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="col-md-7">
            <label for="email" class="col-sm-1 col-form-label">Email</label>
            <input class="form-control" type="email" id="email" name="email" placeholder="Enter email address" required><br>
        </div>
    </div>

    <div class="form-group">
        <label for="details" class="col-sm-5 col-form-label">Additional Information</label>
        <textarea class="form-control" id="details" name="details" rows="7" placeholder="Tell a bit more about the solution you require" required></textarea><br>
    </div>

    <input type="submit" value="Submit" class="btn btn-info">
</form>

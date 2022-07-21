---
title: Opsec & Other Services
excerpt: For any other solutions please fill out this form and we'll be in contact with you ASAP.
image: https://i2.lensdump.com/i/t9FVSe.png
slug: other
num: 2
---

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin volutpat nisi vel eros scelerisque consequat. Proin leo lectus, iaculis eu velit sed, accumsan hendrerit odio. Vestibulum porttitor dolor non neque imperdiet, sit amet commodo diam viverra. Duis auctor orci sit amet scelerisque scelerisque. Nam tempus at est nec mollis. Cras sit amet ultrices leo. Suspendisse tempor ultricies justo, a malesuada enim pellentesque id.</p>

<form method="post" action="{{ route('contact.store') }}">
    <div class="row">
        <div class="col-md-5">
            <label for="selection" class="col-form-label">Desired Solution</label>
            <select name="selection" id="selection" class="form-select">
                <option value="Opsec Services">Opsec Services</option>
                <option value="Network Infrastructure">Network Infrastructure</option>
                <option value="Cloud Services">Cloud Services</option>
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
        <textarea class="form-control" id="details" name="details" rows="7" placeholder="Tell a bit more about the solution you require"></textarea><br>
    </div>

    <input type="submit" value="Submit" class="btn btn-info">
</form>

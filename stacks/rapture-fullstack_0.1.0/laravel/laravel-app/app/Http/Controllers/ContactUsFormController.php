<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Contact;
use Mail;

class ContactUsFormController extends Controller {

    // Store Contact Form data
    public function ContactUsForm(Request $request) {
        // Form validation
        $this->validate($request, [
            'selection' => 'required',
            'details' => 'required',
            'email' => 'required|email',
        ]);
        //  Store data in database
        Contact::create($request->all());
        //  Send mail to admin
        \Mail::send('mail', array(
            'selection' => $request->get('selection'),
            'details' => $request->get('details'),
            'email' => $request->get('email'),
        ), function($message) use ($request){
            $message->from($request->email);
            $message->to('campbell.ohlsen@gmail.com', 'Admin')->subject('TechJunkies - New Request');
        });
        return back()->with('success', 'Thanks for contacting us.  We will get back to you ASAP');
    }
}

jQuery ->
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	payment.setupForm()

payment =
	setupForm: ->
		$('#new_order').submit ->
			$('input[type=submit]').attr('disabled', true)
			payment.processCard()
			false

	processCard: ->  
    card =  
      number: $('#card_number').val()  
      cvc: $('#card_code').val()  
      expMonth: $('#date_month').val()  
      expYear: $('#date_year').val()  
    Stripe.createToken(card, payment.handleStripeResponse)

	handleStripeResponse: (status, response) ->  
	    if status == 200  
	      	$('#new_order').append($('<input type="hidden" name="stripeToken" />').val(response.id))  
	      	$('#new_order')[0].submit()
	    else  
	     	$('#stripe_error').text(response.error.message).show()
	     	$('input[type=submit]').attr('disabled', false)
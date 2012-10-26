if Rails.env == "development"
	Stripe.api_key = "sk_190fdn9FJBeZHZ5vxE3mQpzVvA14d"
	STRIPE_PUBLIC_KEY = "pk_3DoGLoNWEMh4o6Y5tCNuxVbC7lbRg"
elsif Rails.env == "production"
	Stripe.api_key = "sk_190fdn9FJBeZHZ5vxE3mQpzVvA14d"
	STRIPE_PUBLIC_KEY = "pk_3DoGLoNWEMh4o6Y5tCNuxVbC7lbRg"
end
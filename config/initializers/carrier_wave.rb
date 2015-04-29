# Amazon Web Service config.
if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {
		  :provider => 'AWS',
		  :aws_access_key_id     => 'AKIAJ7CYLCT3UBZAVJ2Q',
		  :aws_secret_access_key => 'AWSSecretKey=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',
		  :region                => 'eu-central-1'
		}
		config.fog_directory     =  ENV['railsproject-bucket']
	end
end
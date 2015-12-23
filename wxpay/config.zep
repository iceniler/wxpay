namespace WXPay;

class Config extends Option {

    protected app_id;

    protected mch_id;

    protected app_key;

    protected client_cert;

    protected client_key;

    public function __construct(array! options = null)
    {
		var key, value;

		for key, value in options {
		    if this->offsetExists(key) {
			    this->offsetSet(key, value);
		    }
		}
    }
}
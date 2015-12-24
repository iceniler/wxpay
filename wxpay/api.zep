namespace WXPay;

use WXPay\Library\Util;

class Api extends Option
{

    private api_url = "";

    private is_secure_pay = false;

    private _required_properties = [];

    private _optional_properties = [];

    private _either_groups = [];

    private _config ;

    protected _make_exclude_properties = ["appid", "mch_id", "trade_type", "sign"];//, "nonce_str", "spbill_create_ip"];

    protected sign;

    public static function make(array config) -> <\WXPay\Api>
    {
        var api, class_name;
        let class_name = get_called_class();
        let api = new {class_name}(config);
        return api;
    }

    public function signWith(<\WXPay\Config> config = null) ->  <\WXPay\Api>
    {
        var field, group_through, item, messages;

        if ! (config instanceof \WXPay\Config) {
            throw new \Exception("Invalid \\WXPay\\Config!");
        }

        if !isset this->{"nonce_str"} || empty this->{"nonce_str"} {
            let this->nonce_str = Util::genRandomString(24);
        }

        let messages = [];

        for field in this->_required_properties {

            if in_array(field, this->_either_groups) {
                let group_through = false;
                for item in this->_either_groups {
                    if ! empty this->{item} {
                        let group_through = true;
                    }
                }
                if !group_through {

                    let messages[] = implode(", ", this->_either_groups);
                } else {

                    continue;
                }
            }

            if !in_array(field, this->_make_exclude_properties) && !isset this->{field} {

                let messages[] = field;
            }

            if !in_array(field, this->_make_exclude_properties) && empty this->{field} {

                let messages[] = field;
            }
        }

        if count(messages) > 0 {
            throw new \Exception("Must provide those fields: {". implode(", ", messages) ."}");
        }

        let this->appid = config->app_id;
        let this->mch_id = config->mch_id;
        let this->sign = Util::make_sign(this, config->app_key);
        let this->_config = config;
        return this;
    }

    public function dump() -> string!
    {
        array parameters = [], mergedArray = [];
        var property, xml;

        let mergedArray = mergedArray->merge(this->_required_properties, this->_optional_properties);
        for property in mergedArray {
            if ! empty this->{property} {
                let parameters[property] = this->{property};
            }
        }
        ksort(parameters);
        let xml = Util::convertArrayToXml(parameters);

        return xml . PHP_EOL;
    }


    public function fire() -> array
    {
        array parameters = [], mergedArray = [];
        var responseArray, property, xml;

        let mergedArray = mergedArray->merge(this->_required_properties, this->_optional_properties);
        for property in mergedArray {
            if ! empty this->{property} {
                let parameters[property] = this->{property};
            }
        }
        ksort(parameters);
        let xml = Util::convertArrayToXml(parameters);

        if this->is_secure_pay {
            let responseArray = Util::callWeChatApi(this->api_url, xml, this->_config->client_cert, this->_config->client_key);
        } else {
            let responseArray = Util::callWeChatApi(this->api_url, xml);
        }

        return responseArray;
    }

}
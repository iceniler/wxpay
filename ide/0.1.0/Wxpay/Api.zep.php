<?php

namespace WXPay;


class Api extends \WXPay\Option
{

    private $api_url = "";


    private $is_secure_pay = false;


    private $_required_properties = array();


    private $_optional_properties = array();


    private $_either_groups = array();


    private $_config;


    protected $_make_exclude_properties = array("appid", "mch_id", "trade_type", "sign");


    protected $sign;


    /**
     * @param array $config 
     * @return \Wxpay\Api 
     */
    public static function make($config) {}

    /**
     * @param mixed $config 
     * @return \Wxpay\Api 
     */
    public function signWith(\WXPay\Config $config = null) {}

    /**
     * @return string 
     */
    public function dump() {}

    /**
     * @return array 
     */
    public function fire() {}

}

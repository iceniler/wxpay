<?php

use \Wxpay\Api\App\CreateOrder as AppCreateOrder;
use \Wxpay\Api\App\QueryOrder as AppQueryOrder;
use \Wxpay\Api\App\CloseOrder as AppCloseOrder;

$config = new \Wxpay\Config(array(
    'app_id'      => 'wx9682fc7c2ab8xxxx',
    'mch_id'      => '126356xxxx',
    'app_key'     => 'bdc9a212a1d74b793eea977fd7f7xxxx',
    'client_cert' => dirname(__FILE__) . '/apiclient_cert.pem',
    'client_key'  => dirname(__FILE__) . '/apiclient_key.pem',
));

$payment = array(
    'out_trade_no'     => 'ord_10001' . time(),
    'body'             => '测试测试',
    'total_fee'        => '1',
    'notify_url'       => 'http://www.silversnet.com/wxpay/notify',
    'spbill_create_ip' => '127.0.0.1',
);

echo "统一下单接口返回：" . PHP_EOL;
$createOrderResult = AppCreateOrder::make($payment)
    ->signWith($config)
    ->fire();
echo json_encode($createOrderResult, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT) . PHP_EOL;


echo "订单查询返回：" . PHP_EOL;
$queryOrderResult = AppQueryOrder::make(array(
    'out_trade_no' => $payment['out_trade_no'],
))
    ->signWith($config)
    ->fire();
echo json_encode($queryOrderResult, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT) . PHP_EOL;


echo "关闭订单返回：" . PHP_EOL;
$closeOrderResult = AppCloseOrder::make(array(
    'out_trade_no' => $payment['out_trade_no'],
))
    ->signWith($config)
    ->fire();
echo json_encode($closeOrderResult, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT) . PHP_EOL;


exit;

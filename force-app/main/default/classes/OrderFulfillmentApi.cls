@RestResource(urlMapping='/Orders')
global with sharing class OrderFulfillmentApi {
    @HttpPost
    global static List<Order> updateOrders() {
        RestRequest req = RestContext.request;

        Map<String, Object> keyValueMap = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());

        OrderFulfillmentRequest orderfulFillmentRequest = (OrderFulfillmentRequest) JSON.deserialize(req.requestBody.toString(), OrderFulfillmentRequest.class);

        List<Order> orders = new List<Order>();

        List<Object> orderObjectList = (List<Object>) keyValueMap.get('orders');

        for (Object orderObject : orderObjectList) {
            Map<String, Object> orderObjectKeyValues = (Map<String, Object>) orderObject;

            Order order = new Order(Id = (String) orderObjectKeyValues.get('orderId'), Status = (String) orderObjectKeyValues.get('status'));
            orders.add(order);
        }

        update orders;

        RestResponse res = new RestResponse();
        res.statusCode = 200;
        RestContext.response = res;
        return orders;
    }
}

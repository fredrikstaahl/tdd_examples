@RestResource(urlMapping='/Orders')
global with sharing class OrderFulfillmentApi {
    @HttpPost
    global static List<Order> updateOrders() {
        RestRequest req = RestContext.request;

        Map<String, Object> keyValueMap = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
        System.debug(keyValueMap);

        Id orderId = 'test'; //keyValueMap.get('orderId');
        String status = 'test'; //keyValueMap.get('status');

        Order orderToUpdate = [SELECT Id FROM Order WHERE Id = :orderId LIMIT 1];
        orderToUpdate.Status = status;
        update orderToUpdate;

        RestResponse res = new RestResponse();
        res.statusCode = 200;
        RestContext.response = res;
        return null;
    }
}

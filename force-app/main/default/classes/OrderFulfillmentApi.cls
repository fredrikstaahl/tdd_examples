@RestResource(urlMapping='/Orders')
global with sharing class OrderFulfillmentApi {
    @HttpPost
    global static List<Order> updateOrders() {
        return null;
    }
}

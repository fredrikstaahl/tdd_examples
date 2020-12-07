@IsTest
public with sharing class OrderFulfillmentApiTest {
    @TestSetup
    static void setupTestData() {
        Account acc = new Account(Name = 'testAcc');
        insert acc;

        Order order = new Order();
        order.Status = 'Draft';
        order.AccountId = acc.Id;
        order.EffectiveDate = Date.today();
        order.Pricebook2Id = Test.getStandardPricebookId();
        insert order;

        Product2 product = new Product2();
        product.Name = 'testProduct';
        insert product;

        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), UnitPrice = 10, Product2Id = product.Id);
        insert pbe;

        OrderItem oi = new OrderItem(OrderId = order.Id, Product2Id = product.Id, PricebookEntryId = pbe.Id, UnitPrice = pbe.UnitPrice, Quantity = 1);
        insert oi;
    }

    @IsTest
    static void OrderFulfillmentApiTest_Positive() {
        Order order = [SELECT Id FROM Order LIMIT 1];
        RestRequest request = new RestRequest();

        Id orderId = order.Id;
        String status = 'Activated';
        String trackingId = 's01kfjamd51';

        String body = '{"orders":[{"orderId":"' + orderId + '", "status": "' + status + '", "trackingId": "' + trackingId + '" } ]}';
        System.debug(body);
        request.requestBody = Blob.valueOf(body);
        request.httpMethod = 'POST';

        RestContext.request = request;

        OrderFulfillmentApi.updateOrders();

        RestResponse response = RestContext.response;

        System.assertEquals(200, response.statusCode, 'Should return response code 200');

        Order orderAfterUpdate = [SELECT Id, Status FROM Order WHERE Id = :order.Id LIMIT 1];

        System.assertEquals(orderAfterUpdate.Status, 'Activated');
    }

    @IsTest
    static void OrderFulfillmentApiTest_Negative_400() {
        RestRequest request = new RestRequest();

        String status = 'Activated';
        String trackingId = 's01kfjamd51';

        String body = '{[{status: "' + status + '", trackingId: “' + '" } ]}';
        request.requestBody = Blob.valueOf(body);
        request.httpMethod = 'POST';

        RestContext.request = request;
        RestResponse response = RestContext.response;

        OrderFulfillmentApi.updateOrders();

        System.assertEquals(400, response.statusCode, 'Should return response code 400');
    }
}

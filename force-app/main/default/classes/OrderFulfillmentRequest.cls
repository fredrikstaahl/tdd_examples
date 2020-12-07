public class OrderFulfillmentRequest {
    List<OrderUpdate> orders;

    public OrderFulfillmentRequest() {
    }

    public class OrderUpdate {
        String orderId;
        String status;
        String trackingId;

        public OrderUpdate() {
        }
    }
}

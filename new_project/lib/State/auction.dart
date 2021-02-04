class Auction {
  final int auctionID;
  final int ownerID;
  int maxParticipants;
  int round_num;
  int round_current;
  String material;
  String title;
  String state;
  String contract;
  bool consumer;
  int categoryID;

  //Constructor
  Auction(
      this.auctionID,
      this.ownerID,
      this.maxParticipants,
      this.round_num,
      this.round_current,
      this.material,
      this.title,
      this.state,
      this.contract,
      this.consumer,
      this.categoryID);
}

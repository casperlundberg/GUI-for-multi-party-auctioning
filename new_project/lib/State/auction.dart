class Auction {
  final int auctionID;
  final int ownerID;
  int maxParticipants;
  int currentParticipants;
  int roundNumber;
  int roundCurrent;
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
      this.currentParticipants,
      this.roundNumber,
      this.roundCurrent,
      this.material,
      this.title,
      this.state,
      this.contract,
      this.consumer,
      this.categoryID);
}

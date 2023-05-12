enum SavedTrainType {
  recents,
  favourites,
}

// Get label from SavedTrainType
String getSavedTrainTypeLabel(SavedTrainType savedTrainType) {
  switch (savedTrainType) {
    case SavedTrainType.recents:
      return "recenti";
    case SavedTrainType.favourites:
      return "preferiti";
    default:
      return "";
  }
}

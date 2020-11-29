const int SEARCH_TRAIN_STATUS = 0;
const int SHOW_TRAIN_STATUS = 1;
const int SEARCH_SOLUTIONS = 0;
const int SHOW_SOLUTIONS = 1;

// Utilizzato per far scegliere il treno quando hanno lo stesso numero
Map<String, String> trainNames = {
  "REG": "Regionale",
  "EC": "EuroCity",
  "IC": "Intercity",
  "FR": "Frecciarossa"
};

Map<String, String> trainAcronym = {
  "Regionale": "REG",
  "EuroCity": "EC",
  "Intercity": "IC",
  "Frecciarossa": "FR"
};

Map<String, String> trainTypeFromNumber = {
  "246": "FR",
  "235": "RV",
  "197": "REG",
  "196": "REG",
  "205": "EC",
  "214": "IC"
};

// maybe in future will init translations,
// but for now save the strings used across
// the app, to make it easier to translate

const translations = {
  'game_over': 'Game Over',
  'restart': 'Restart',
  'settings': 'Settings',
};

getStr(String key) {
  return translations[key];
}

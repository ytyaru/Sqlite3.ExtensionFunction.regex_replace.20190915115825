SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# SQLite3本体のソースコードを入手
wget https://www.sqlite.org/2019/sqlite-src-3290000.zip
unzip sqlite-src-3290000.zip

# 拡張関数のソースコードを入手
git clone https://github.com/gwenn/sqlite-regex-replace-ext
cd sqlite-regex-replace-ext

# 拡張関数のビルド
gcc --shared -fPIC -I "$SCRIPT_DIR"/sqlite-autoconf-3290000 icu_replace.c -o icu_replace.so

# 動作確認
sqlite3 :memory: \
".load ./icu_replace.so" \
"select regex_replace('ABC', 'ABC123ABC123ABC' ,'あいう');"


flutter build web
rm -rf out/*
mv build/web/* out/
mv out/assets/assets/images out/assets
rm -rf out/assets/assets

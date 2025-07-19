#!/bin/bash
git config --local user.email "becare4@tutanota.com";
git config --local user.name "nodebe4";
git config --local pull.rebase false;

now=$(date +"%F");

datediff () {
  D1=$(date -d "$1" '+%s');
  D2=$(date -d "$2" '+%s');
  echo "$(((D2-D1)/86400))";
}

echo ${now};

FILES=./_posts/*
for f in $FILES
do
  f_date=${f:9:10};
  d_date=$(datediff "${f_date}" "${now}");
  # take action on each file. $f store current file name
  if (( d_date > 120 ));
    then
      # code if found
      mkdir -p "./archived/${f_date}";
      echo "Archive $f";
      git mv "${f}" "./archived/${f_date}/";
  fi
done

git add ./archived/*.md;
git commit -m"存档${today}之前120天的内容";
git pull;
git push;

echo "120天前的新闻已存档至 archived, ${now}";

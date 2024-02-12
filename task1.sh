#!/bin/bash

# Перевірка аргументу
if [ $# -ne 1 ]; then
  echo "Використання: $0 <шлях до файлу accounts.csv>"
  exit 1
fi

# Вхідний файл
input_file="$1"

# Вихідний файл
output_file="accounts_new.csv"

# Обробка файлу
echo "Обробка файлу $input_file..."

# Створення нового файлу
> "$output_file"

# Запис першого рядка без змін
head -n 1 "$input_file" >> "$output_file"

# Цикл для редагування рядків
tail -n +2 "$input_file" | while IFS=, read -r id location name title department; do

  # Отримання імені та прізвища
  name_parts=(${name// / })
  name_upper="${name_parts[0]^}"
  name_lower="${name_parts[0],,}"
  surname_upper="${name_parts[1]^}"
  surname_lower="${name_parts[1],,}"

  # Оновлення email
  email_username="${name_lower:0:1}${surname_lower}${location}"
  email_domain="@abc.com"

  # Запис нового рядка
  echo "$id,$location,$name_upper $surname_upper,$title,$email_username$email_domain,$department" >> "$output_file"

done

echo "Файл $output_file успішно створено!"









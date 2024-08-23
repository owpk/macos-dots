#!/bin/sh

# Explanation of the script:
# 
# 1. Main project:
# • git fetch origin main: Get updates from the master branch of the remote repository.
# • git merge -X ours origin/main: Merge changes from the remote repository into the current local branch with the -X ours option, which in case of a conflict accepts the current local changes.
# 2. Submodules:
# • git submodule update --remote --recursive: Update all submodules, switching them to the latest commits in their branches.
# • git submodule foreach --recursive ...: Go through each submodule and perform the same update as for the main project.
# 3. Updating the state of submodules in the main project:
# • git add .: Add changes (updated commits of submodules) to the index.
# • git commit -m "Updated submodules with merge strategy ours": Create a commit with updated submodules.
# 
# How to use:
# 
# 1. Save this script to a file, for example, update.sh.
# 2. Make it executable: chmod +x update.sh.
# 3. Run the script: ./update.sh.
# 
# This script will update your main project and submodules, resolving conflicts in favor of local changes.


# Пояснение к скрипту:
# 
# 	1.	Основной проект:
# 	•	git fetch origin main: Получаем обновления из ветки master удаленного репозитория.
# 	•	git merge -X ours origin/main: Мержим изменения с удаленного репозитория в текущую локальную ветку с опцией -X ours, которая в случае конфликта принимает текущие локальные изменения.
# 	2.	Сабмодули:
# 	•	git submodule update --remote --recursive: Обновляем все сабмодули, переключая их на последние коммиты в их ветках.
# 	•	git submodule foreach --recursive ...: Проходим по каждому сабмодулю и выполняем аналогичное обновление, как и для основного проекта.
# 	3.	Обновление состояния сабмодулей в основном проекте:
# 	•	git add .: Добавляем изменения (обновленные коммиты сабмодулей) в индекс.
# 	•	git commit -m "Updated submodules with merge strategy ours": Создаем коммит с обновленными сабмодулями.
# 
# Как использовать:
# 
# 	1.	Сохраните этот скрипт в файл, например, update.sh.
# 	2.	Сделайте его исполняемым: chmod +x update.sh.
# 	3.	Запустите скрипт: ./update.sh.
# 
# Этот скрипт будет обновлять ваш основной проект и сабмодули, 
# разрешая конфликты в пользу локальных изменений.

git config diff.submodule log
git config -f .gitmodules submodule.server-dots.branch main

# Обновление основного проекта
git fetch origin main
git merge -X ours origin/main

# Обновление всех сабмодулей
git submodule update --remote --recursive

# Проход по всем сабмодулям и мерж изменений
git submodule foreach --recursive '
    branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch origin $branch
    git merge -X ours origin/$branch
'

# Сообщение для коммита
COMMIT_MESSAGE="$(date +'%Y-%m-%d')-updates"

# Проход по каждому сабмодулю и выполнение коммита
git submodule foreach --recursive '
    git add .
    git commit -m "$COMMIT_MESSAGE"
'

# Обновляем индекс основного проекта с новым состоянием сабмодулей
git add .
git commit -m "$COMMIT_MESSAGE"

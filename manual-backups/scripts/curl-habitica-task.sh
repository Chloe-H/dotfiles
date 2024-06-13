user_id=""
auth_token=""
task_id=""
output_file=""
default_output_file="./exported-task.json"

read -p "User ID: " user_id
read -p "API Token: " auth_token
read -p "Task ID (from https://tools.habitica.com/): " task_id
read -p "Output file (${default_output_file}): " output_file

output_file="${output_file:-${default_output_file}}"

curl \
    -H "x-api-user: ${user_id}" \
    -H "x-api-key: ${auth_token}" \
    --output ${output_file} \
    https://habitica.com/api/v3/tasks/${task_id} \
&& printf "\nDownloaded task ${task_id} to ${output_file}."

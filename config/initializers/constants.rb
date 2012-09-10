case Rails.env
when 'production'
  MY_SITE_NAME="http://notestoquiz.herokuapp.com/"
when 'development'
  MY_SITE_NAME="http://localhost:3000/"
end

QUIZLET_CLIENT_ID = "3aXxhbg4GH"
QUIZLET_CLIENT_SECRET = "MrFpVqEQcIldTuW-cZmD4A"

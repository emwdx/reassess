<!DOCTYPE html>
<html lang="en">
<script type="text/javascript" src="/static/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
<script src = "/static/jquery/jquery-1.7.2.min.js"></script>

<head>
<title>QuizMe</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">
</head>

<body>
<div class="container-fluid">
%for questions in classQuestionSet:
{{questions[0]}}  
%number = 1
%length = len(questions[1])



%for question in questions[1]:

<! -This starts the question>



%if(questions[1][number-1][2]!=''):

<div class="row-fluid">
    <div class="span5">
     <img src = "{{questions[1][number-1][2]}}"> 
    </div>
    
    <div class="span7">
      <div class = "hero-unit" >
      <h4>{{! questions[1][number-1][0]}}</h4>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! questions[1][number-1][1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>

%else:
<div class="row-fluid">
    
    
    <div class="span12">
      <div class = "hero-unit" >
      <h4>{{! questions[1][number-1][0]}}</h4>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! questions[1][number-1][1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>
%end
<! - This ends the question unit >
%number +=1
%end
%end
</div>
</body>
</html>


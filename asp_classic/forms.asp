<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <title>Classic ASP - Forms</title>
    <style>
        body {
            width: 66em;
        }
    </style>
</head>
<body>
    <h1>Classic ASP - Forms</h1>
    <!-- #include file="menu.asp" -->
    <form method="post" action="forms.asp">
        <fieldset>
            <legend>Full Name</legend>
            <input name="full_name" type="text" value='<%= Request("full_name") %>' />
        </fieldset>
        <fieldset>
            <legend>Gender</legend>
            <label>
            <input name="gender" type="radio" value="Male" <% if Request("gender")="Male" then Response.Write("checked") end if %> />
                Male
            </label>
            <label>
            <input name="gender" type="radio" value="Female" <% If Request("gender")="Female" then Response.Write("checked") end if %> />
                Female
            </label>
        </fieldset>
        <fieldset>
            <legend>Age Group</legend>
            <select name="age_group">
                <option <% If Request("age_group")="" then Response.Write("selected") end if %>></option>
                <option <% If Request("age_group")="Child" then Response.Write("selected") end if %>>Child</option>
                <option <% If Request("age_group")="Teen" then Response.Write("selected") end if %>>Teen</option>
                <option <% If Request("age_group")="Adult" then Response.Write("selected") end if %>>Adult</option>
                <option <% If Request("age_group")="Senior" then Response.Write("selected") end if %>>Senior</option>
            </select>
        </fieldset>
        <fieldset>
            <legend>Education</legend>
            <label>
            <input name="highschool" type="checkbox" <% If Request("highschool")="on" then Response.Write("checked") end if %> />
                High School
            </label>
            <label>
            <input name="college" type="checkbox" <% If Request("college")="on" then Response.Write("checked") end if %> />
                College
            </label>
        </fieldset>
        <fieldset>
            <legend>Comment</legend>
            <textarea name="comment" rows="5" cols="40"><%= Request("comment") %></textarea>
        </fieldset>
        <input type="submit" />
    </form>
    <p>full_name = <%= Request("full_name") %></p>
    <p>gender = <%= Request("gender") %></p>
    <p>age_group = <%= Request("age_group") %></p>
    <p>highechool = <%= Request("highschool") %></p>
    <p>college = <%= Request("college") %></p>
    <p>comment = <%= Replace(Request("comment"), vbcrlf, "<br />") %></p>
</body>
</html>

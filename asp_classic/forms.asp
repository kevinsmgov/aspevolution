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
            <input name="full_name" type="text" />
        </fieldset>
        <fieldset>
            <legend>Gender</legend>
            <label>
            <input name="gender" type="radio" value="Male" />
                Male
            </label>
            <label>
            <input name="gender" type="radio" value="Female" />
                Female
            </label>
        </fieldset>
        <fieldset>
            <legend>Age Group</legend>
            <select name="age_group">
                <option></option>
                <option>Child</option>
                <option>Teen</option>
                <option>Adult</option>
                <option>Senior</option>
            </select>
        </fieldset>
        <input type="submit" />
    </form>
    <p>full_name = <%= Request("full_name") %></p>
    <p>gender = <%= Request("gender") %></p>
    <p>age_group = <%= Request("age_group") %></p>
</body>
</html>

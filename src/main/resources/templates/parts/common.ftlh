<#macro page>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

    <#nested>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
    </html>
</#macro>

<#macro header admin>
    <header>
        <nav>
            <div class="nav-wrapper container">
                <a href="#" class="brand-logo">Board</a>
                <ul id="nav-mobile" class="right">
                    <li>
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${ _csrf.token}" />
                            <input class="btn" type="submit" value="Sign Out">
                        </form>
                    </li>
                    <#if admin == "ADMIN">
                        <li>
                            <a class="btn" href="/user">Users</a>
                        </li>
                    </#if>
                </ul>
            </div>
        </nav>
    </header>
</#macro>
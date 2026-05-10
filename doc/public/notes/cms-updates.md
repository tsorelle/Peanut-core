[Return to docs home page](../index.md)

## Superceded

see [deployment-notes-2025.md](../../../deployment/2025/deployment-notes-2025.md)

# Interactive Changes on Deployment

These changes, made "by hand" in ConcreteCMS may be needed 
after initial deployment. 

## Checklist

1. Update from prod and testing (See: [notes.md](../../../deployment/2025/notes.md)
2. Activate FMA Theme
2. System & Settings
   - Clear cache
2. [Front page](#front-page)
   - Edit nav: 
     - logo: sign-logo-96-px.jpg, sign-logo-transparent (Images are pre-uploaded.)
       If file error occurs, delete the nav and replace it. see the 
     Front page section
   - Check for duplicate "more events..." link.

## Settings

### Site Name
In "System & Settings" > "Basic" > "Name & Attribute": Change 'Site Name' to "Friends Meeting of Austin".

![site-name-setting.jpg](img/site-name-setting.jpg)

### Design and Block Template
Many of the instructions below require a change to "Custom Classes" or "Block Template".

For a general explantion of how to make these changes,
see:  [Templates and Styles](templates-and-styles.md)

## Front page
  - Add top header navigation block<br>
   ![Top nav](img/top-nav.jpg)<br>
      - Enable all options except "Ignore page permissions"<br>
     ![Top nav props](img/top-nav-props.jpg)
      - Under "Branding" select or upload logos: simple-dove-logo-bluish-80.png and
        simple-dove-logo-bluish-transparent.png<br>
      ![branding-logo.jpg](img/branding-logo.jpg)<br>
        (We may find better images later. Watch for updates)
    - Set block template: Fma Top Navigation
- Add Hero Image
  - Image: select world-quaker-day-2410x839-90 from file manager 
  (will be replaced later with a better image. Watch for updates)<br>
  ![hero-image.jpg](img/hero-image.jpg)
### Page Settings

In page settings, select "SEO". Change "Meta Title" to "Friends Meeting of Austin"

![front-page-settings-title.jpg](img/front-page-settings-title.jpg)

### Front page Content
- Remove right column image
- Move left column content to single column above 
- Move Events page list to right column.

### Footer
  In edit mode there are three areas in the footer:
  ![footerareas.jpg](img/footerareas.jpg)


#### SITEWIDE FOOTER COLUMN 1
Content block:
```html
<div id="footer-address-block">
<div id="footer-title-block"><a href="/index.php?cID=1" id="footer-site-title">Friends Meeting of Austin</a></div>

<p>3701 East Martin Luther King<br />
Austin, Texas</p>

<p><a href="https://www.bing.com/maps?&amp;ty=18&amp;q=Friends%20Meeting%20of%20Austin%2C%203701%20E%20Martin%20Luther%20King%20Jr%20Blvd%2C%20Austin%2C%20TX%2C%20United%20States" target="_blank">View on Map</a></p>

<p><a href="/about-us/privacy-policy">Privacy Policy</a></p>
</div>

```

#### SITEWIDE FOOTER COLUMN 2
Content block 1:
```html
<p><a class="menu-link" href="/index.php?cID=740" title="Send a message to Friends Meeting of Austin">Contact us <i aria-hidden="true" class="fa fa-envelope"></i></a></p>

<p><a class="menu-link" href="/contribute" title="Giving opportunities">Contributions <i aria-hidden="true" class="fa fa-credit-card"></i></a></p>

<p><a class="menu-link" href="/news/calendar" title="Meeting Calendar">Calendar <i aria-hidden="true" class="fa fa-calendar"></i></a></p>

<p><a class="menu-link" href="/emailings" title="Join our email lists">Email subscriptions <i aria-hidden="true" class="fa fa-paper-plane"></i></a></p>

```
Content block 2:
```html
<p><a class="menu-link" href="/community/directory/members" title="Member and attender directory">Directory <i aria-hidden="true" class="fa fa-users"></i></a></p>
```
- Set block template  "Peanut Authenticated Content". 

#### SITEWIDE FOOTER COLUMN 3
- move meeting house pick to footer right column

Do not add "Report a bug" link.

## Page List Formatting (Completed in production)
- Landing Page List
  - In 'Design & Block' template, add 'landing-page-list' class to the page list block. Block template should be default.
  On these pages:
    - Community > Video
    - Community > Education
    - Help > Guest Help
- Sidebar Page Lists.
    - In 'Design & Block' template, add 'sidebar-page-list' or 'landing-page-list-compact' class to the page list 
  block in the left column.
      On these pages:
      - Community > Contacts
      - News > Fma Online

## Online Page
(completed in production)
  - Apply the "pnut-basic-pagelist" custom class to right colum 
  pagelist. (see above)
- "Contact FMA Page" Map
  - Api key: AIzaSyCGI87Pg2OjivlJPS_KJ1HocgWGlPkpMCY
  - Change title to h4<br>
  ![contact-page-map.jpg](img/contact-page-map.jpg)
## Community page
(completed in production)
  - On page list > Design and Block Template (see above)
    - Change the Block Template to 'Default'
    - Custom Class: landing-page-menu
  - Tasks page
    - Delete autonav block
    - Replace with pagelist block
    - in Design and block template.  Add class 'landing-page-list'
## Help pages
(completed in production)
- Apply the "landing-page-list" custom class to the page  list on:
  - Guest Help
  - Members Help
  - Content Authors
- Remove "transfer old account"
## Basic Content Editing
(completed in production)
- Replace content in the "References" content block:
```html
<h4>References:</h4>

<ul>
	<li><a href="https://documentation.concretecms.org/9-x/user-guide" target="_blank">ConcreteCMS Users Guide</a></li>
	<li><a href="https://testing.austinquakers.org">Testing site - https://testing.austinquakers.org</a></li>
</ul>

```
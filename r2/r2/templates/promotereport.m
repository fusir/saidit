## The contents of this file are subject to the Common Public Attribution
## License Version 1.0. (the "License"); you may not use this file except in
## compliance with the License. You may obtain a copy of the License at
## http://code.reddit.com/LICENSE. The License is based on the Mozilla Public
## License Version 1.1, but Sections 14 and 15 have been added to cover use of
## software over a computer network and provide for limited attribution for the
## Original Developer. In addition, Exhibit A has been modified to be
## consistent with Exhibit B.
##
## Software distributed under the License is distributed on an "AS IS" basis,
## WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
## the specific language governing rights and limitations under the License.
##
## The Original Code is reddit.
##
## The Original Developer is the Initial Developer.  The Initial Developer of
## the Original Code is reddit Inc.
##
## All portions of the code written by reddit are Copyright (c) 2006-2015
## reddit Inc. All Rights Reserved.
###############################################################################


<%!
   from r2.lib import js
   from r2.lib.template_helpers import format_number
%>

<%namespace name="pr" file="promotelinkbase.m" />
<%namespace file="utils.m" import="plain_link" />
<%namespace name="utils" file="utils.m"/>

${unsafe(js.use('sponsored'))}

<div class="sponsored-page">
  <div class="dashboard reporting-dashboard">
    <header>
      <h2>sponsored link report</h2>
      <p class="note">
        note: the end date is not included, so selecting 1/2/2013-1/3/2013 will retrieve traffic for the day of 1/2/2013 only.
      </p>
    </header>
    <div class="dashboard-content">
      <div class="editor">
        <div class="editor-group">
          ${pr.scheduling_field()}
          <%utils:line_field title="${_('grouping')}" css_class="rounded timing-field">
            <select id="grouping" name="grouping">
              <option value="total" ${"" if thing.group_by_date else "selected='selected'"}>total</option>
              <option value="day" ${"selected='selected'" if thing.group_by_date else ""}>daily</option>
            </select>
          </%utils:line_field>
          ${pr.reporting_field(link_text=thing.link_text, owner=thing.owner_name)}
        </div>
        <footer class="buttons">
          <button name="submit" onclick="r.sponsored.submit_reporting_form()">submit</button>
        </footer>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  r.sponsored.set_form_render_fnc(r.sponsored.fill_reporting_form);
  $(function() {
    init_startdate();
    init_enddate();
    r.sponsored.render();
  });
</script>

%if thing.link_report:
<h1>links</h1>
<table id="link-report" class="promote-report-table">
  <thead>
    <tr>
      %if thing.group_by_date:
        <th>date</th>
      %endif
      <th>id</th>
      <th>owner</th>
      <th>comments</th>
      <th>upvotes</th>
      <th>downvotes</th>
      <th>clicks</th>
      <th>impressions</th>
    </tr>
  </thead>
  <tbody>
    %for row in thing.link_report:
    <tr>
      %if thing.group_by_date:
        <td class="text">${row['date']}</d>
      %endif
      <td class="text">${row['id36']}</td>
      <td class="text">${row['owner']}</td>
      <td>${format_number(row['comments'])}</td>
      <td>${format_number(row['upvotes'])}</td>
      <td>${format_number(row['downvotes'])}</td>
      <td>${format_number(row['clicks'])}</td>
      <td>${format_number(row['impressions'])}</td>
    </tr>
    %endfor
  </tbody>
</table>
%endif

%if thing.campaign_report:
<h1>campaigns</h1>
<table id="campaign-report" class="promote-report-table">
  <thead>
    <tr>
      %if thing.group_by_date:
        <th class="blank"/>
      %endif
      <th class="blank"/>
      <th class="blank"/>
      <th class="blank"/>
      <th class="blank"/>
      <th class="blank"/>
      <th colspan="2">frontpage</th>
      <th colspan="2">subreddit</th>
      <th colspan="2">total</th>
    </tr>
    <tr>
      %if thing.group_by_date:
        <th>date</th>
      %endif
      <th>link id</th>
      <th>owner</th>
      <th>campaign id</th>
      <th>target</th>
      <th>bid</th>
      <th>clicks</th>
      <th>impressions</th>
      <th>clicks</th>
      <th>impressions</th>
      <th>clicks</th>
      <th>impressions</th>
    </tr>
  </thead>
  <tbody>
    %for row in thing.campaign_report:
    <tr>
      %if thing.group_by_date:
        <td class="text">${row['date']}</td>
      %endif
      <td class="text">${row['link']}</td>
      <td class="text">${row['owner']}</td>
      <td class="text">${row['campaign']}</td>
      <td class="text">${row['target']}</td>
      <td>${row['bid']}</td>
      <td>${format_number(row['fp_clicks'])}</td>
      <td>${format_number(row['fp_impressions'])}</td>
      <td>${format_number(row['sr_clicks'])}</td>
      <td>${format_number(row['sr_impressions'])}</td>
      <td>${format_number(row['total_clicks'])}</td>
      <td>${format_number(row['total_impressions'])}</td>
    </tr>
    %endfor
    <tr class="total">
      %if thing.group_by_date:
        <td></td>
      %endif
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td>${thing.campaign_report_totals['bid']}</td>
      <td>${format_number(thing.campaign_report_totals['fp_clicks'])}</td>
      <td>${format_number(thing.campaign_report_totals['fp_imps'])}</td>
      <td>${format_number(thing.campaign_report_totals['sr_clicks'])}</td>
      <td>${format_number(thing.campaign_report_totals['sr_imps'])}</td>
      <td>${format_number(thing.campaign_report_totals['total_clicks'])}</td>
      <td>${format_number(thing.campaign_report_totals['total_imps'])}</td>
    </tr>
  </tbody>
</table>
%endif

%if thing.csv_url:
<div class="promote-report-csv">
  ${plain_link(unsafe("download as csv"), thing.csv_url)}
</div>
%endif

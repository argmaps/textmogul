# Main navigation handling
$(document).ready ->
  nav_toggler = $("header .toggle-nav")
  nav = $("#main-nav")
  content = $("#content")
  body = $("body")
  click_event = (if jQuery.support.touch then "tap" else "click")

  $("#main-nav .dropdown-collapse").on click_event, (e) ->
    e.preventDefault()
    link = $(this)
    list = link.parent().find("> ul")

    if list.is(":visible")
      if body.hasClass("main-nav-closed") && link.parents("li").length == 1
        false
      else
        link.removeClass("in")
        list.slideUp 300, ->
          $(this).removeClass("in")
    else
      $(document).trigger("nav-open") if list.parents("ul.nav.nav-stacked").length == 1
      link.addClass("in")
      list.slideDown 300, ->
        $(this).addClass("in")
    false

  if jQuery.support.touch
    nav.on "swiperight", (e) ->
      $(document).trigger("nav-open")
    nav.on "swipeleft", (e) ->
      $(document).trigger("nav-close")

  nav_toggler.on click_event, ->
    if nav_open()
      $(document).trigger("nav-close")
    else
      $(document).trigger("nav-open")
    false

  # callbacks
  $(document).bind "nav-close", (event, params) ->
    body.removeClass("main-nav-opened").addClass("main-nav-closed")
    nav_open = false

  $(document).bind "nav-open", (event, params) ->
    body.addClass("main-nav-opened").removeClass("main-nav-closed")
    nav_open = true

@nav_open = ->
  return $("body").hasClass("main-nav-opened") || $("#main-nav").width() > 50

# JS plugins initializations
$(document).ready ->
  setValidateForm()

  # --------------------------------------------------------------------------------------------------------------------
  # removes .box after click on .box-remove button
  $(".box .box-remove").on "click", (e) ->
    $(this).parents(".box").first().remove()
    e.preventDefault()
    return false

  # hides .box after click on .box-collapse
  $(".box .box-collapse").on "click", (e) ->
    box = $(this).parents(".box").first()
    box.toggleClass("box-collapsed")
    e.preventDefault()
    return false
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # check all checkboxes in table with class only-checkbox
  $(".check-all").on "click", (e) ->
    $(this).parents("table:eq(0)").find(".only-checkbox :checkbox").attr "checked", @checked
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up responsive tabs
  $('.nav-responsive.nav-pills, .nav-responsive.nav-tabs').tabdrop() if jQuery().tabdrop
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up bootstrap popovers
  touch = false
  if window.Modernizr
    touch = Modernizr.touch
  unless touch
    $("body").on "mouseenter", ".has-popover", ->
      el = $(this)
      if el.data("popover") is `undefined`
        el.popover
          placement: el.data("placement") or "top"
          container: "body"
      el.popover "show"

    $("body").on "mouseleave", ".has-popover", ->
      $(this).popover "hide"
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up bootstrap tooltips
  touch = false
  if window.Modernizr
    touch = Modernizr.touch
  unless touch
    $("body").on "mouseenter", ".has-tooltip", ->
      el = $(this)
      if el.data("tooltip") is `undefined`
        el.tooltip
          placement: el.data("placement") or "top"
          container: "body"
      el.tooltip "show"

    $("body").on "mouseleave", ".has-tooltip", ->
      $(this).tooltip "hide"
  # --------------------------------------------------------------------------------------------------------------------

  if window.Modernizr && Modernizr.svg == false
    $("img[src*=\"svg\"]").attr "src", ->
      $(this).attr("src").replace ".svg", ".png"

  # --------------------------------------------------------------------------------------------------------------------
  # modernizr fallbacks
  if window.Modernizr
    unless Modernizr.input.placeholder
      $("[placeholder]").focus(->
        input = $(this)
        if input.val() is input.attr("placeholder")
          input.val ""
          input.removeClass "placeholder"
      ).blur(->
        input = $(this)
        if input.val() is "" or input.val() is input.attr("placeholder")
          input.addClass "placeholder"
          input.val input.attr("placeholder")
      ).blur()
      $("[placeholder]").parents("form").submit ->
        $(this).find("[placeholder]").each ->
          input = $(this)
          input.val ""  if input.val() is input.attr("placeholder")
  # --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# form validation
@setValidateForm = (selector = $(".validate-form")) ->
  if jQuery().validate
    selector.each (i, elem) ->
      $(elem).validate
        errorElement: "span"
        errorClass: "help-block has-error"
        errorPlacement: (e, t) ->
          t.parents(".controls").first().append e

        highlight: (e) ->
          $(e).closest('.form-group').removeClass("has-error has-success").addClass('has-error');

        success: (e) ->
          e.closest(".form-group").removeClass("has-error")
# --------------------------------------------------------------------------------------------------------------------

class ZCL_AU_03_I_TRAVELTP definition
  public
  inheriting from /BOBF/CL_LIB_AUTH_DRAFT_ACTIVE
  final
  create public .

public section.

  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY
    redefinition .
  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_AU_03_I_TRAVELTP IMPLEMENTATION.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY.
    data
        lt_travels  type d435b_t_itraveltp.

    data:
                lv_activity type activ_auth.

    case is_ctx-activity.
        when /bobf/cl_frw_authority_check=>sc_activity-create
        or /bobf/cl_frw_authority_check=>sc_activity-change
        or /bobf/cl_frw_authority_check=>sc_activity-display.

        lv_activity = is_ctx-activity.

        when /bobf/cl_frw_authority_check=>sc_activity-execute.

            case is_ctx-action_name.
                when 'set_to_cancelled'.
                    lv_activity = /bobf/cl_frw_authority_check=>sc_activity-display.
     endcase.
     endcase.

  if lv_activity is not initial.
    io_read->retrieve(
    exporting
        iv_node   = is_ctx-node_key
        it_key   = it_key
        importing
            et_data   = lt_travels
            et_failed_key   = et_failed_key
            ).

*    field-symbols
*        <ls_travel> type zs27i_traveltp.
*       loop at lt_travels assigning <ls_travel>.

        loop at lt_travels assigning field-symbol(<ls_travel>)
            where travelagency is not initial.

        cl_s4d435_model=>authority_check(
            exporting
                iv_agencynum = <ls_travel>-travelagency
                iv_actvt  = lv_activity
                receiving
                    rv_rc   = data(lv_subrc) ).

        if lv_subrc <> 0.

            et_failed_key = VALUE #( base et_failed_key ( key = <ls_travel>-key ) ).
       endif.
       endloop.
       endif.

  endmethod.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY.
  endmethod.
ENDCLASS.

class ZCL_03_V_CUSTOMER_EXISTS definition
  public
  inheriting from /BOBF/CL_LIB_V_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_VALIDATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_03_V_CUSTOMER_EXISTS IMPLEMENTATION.


  method /BOBF/IF_FRW_VALIDATION~EXECUTE.

  data lt_travel type d435c_t_itraveltp.

  data lv_exists type abap_bool.

  data lo_msg type ref to cm_devs4d435.
  data ls_location type /bobf/s_frw_location.

  data ls_key like line of et_failed_key.

  io_read->retrieve(
    exporting
        iv_node = is_ctx-node_key
        it_key  = it_key

    importing
        eo_message  = eo_message
        et_data   = lt_travel ).

  loop at lt_travel ASSIGNING field-symbol(<ls_travel>).

    lv_exists = abap_false.

    if <ls_travel>-customer is not initial.

        select single @abap_true
            from d435_i_customer
            into @lv_exists
            where customer = @<ls_travel>-customer.

       if lv_exists <> abap_true.
        if eo_message is not bound.
            eo_message = /bobf/cl_frw_factory=>get_message(  ).
       endif.

        ls_location-bo_key = is_ctx-bo_key.
        ls_location-node_key = is_ctx-node_key.
        ls_location-key = <ls_travel>-key.
        append if_d435c_i_traveltp_c=>sc_node_attribute-d435c_i_traveltp-customer
            to ls_location-attributes.

        create object lo_msg
            exporting
                textid  = cm_devs4d435=>customer_not_exist
                severity  = cm_devs4d435=>co_severity_error
                customer = <ls_travel>-customer
                ms_origin_location = ls_location.

                eo_message->add_cm( lo_msg ).

                ls_key-key = <ls_travel>-key.

            endif.
            endif.
            endloop.
  endmethod.
ENDCLASS.

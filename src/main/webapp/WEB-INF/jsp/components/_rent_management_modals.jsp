<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>    


<style>
    /* ==========================================
       ELIS LEASE / LEDGER DETAILS MODAL
    ========================================== */

    #viewLedgerModal .modal-content {
        border-radius: 12px;
        overflow: hidden;
    }

    #viewLedgerModal .modal-header {
        padding: 18px 24px;
    }

    #viewLedgerModal .modal-body {
        background: #f5f7fb;
        padding: 22px;
    }

    /* ==========================================
       SUMMARY HEADER
    ========================================== */

    #viewLedgerModal .ledger-summary {
        background: #ffffff;
        border: 1px solid #e5e9f0;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
    }

    #viewLedgerModal .ledger-summary-name {
        font-size: 22px;
        font-weight: 700;
        color: #243247;
        margin-bottom: 8px;
        overflow-wrap: anywhere;
    }

    #viewLedgerModal .ledger-summary-label {
        display: block;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        color: #8492a6;
        letter-spacing: 0.5px;
        margin-bottom: 6px;
    }

    #viewLedgerModal .ledger-summary-value {
        display: block;
        font-size: 20px;
        font-weight: 700;
        color: #25364a;
        line-height: 1.5;
        overflow-wrap: anywhere;
    }

    #viewLedgerModal .ledger-account-badge {
        display: inline-block;
        background: #4355b9;
        color: #ffffff;
        padding: 7px 12px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
    }

    /* ==========================================
       SECTION CARDS
    ========================================== */

    #viewLedgerModal .ledger-section {
        background: #ffffff;
        border: 1px solid #e5e9f0;
        border-radius: 10px;
        margin-bottom: 18px;
        overflow: hidden;
    }

    #viewLedgerModal .ledger-section-header {
        padding: 14px 18px;
        border-bottom: 1px solid #edf0f4;
        background: #ffffff;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    #viewLedgerModal .ledger-section-header h6 {
        margin: 0;
        font-size: 15px;
        font-weight: 700;
        color: #344054;
    }

    #viewLedgerModal .ledger-section-header i {
        font-size: 16px;
        color: #4355b9;
    }

    #viewLedgerModal .ledger-section-body {
        padding: 20px 18px 5px;
    }

    /* ==========================================
       FIELD LABELS AND VALUES
    ========================================== */

    #viewLedgerModal .ledger-field {
        margin-bottom: 22px;
    }

    #viewLedgerModal .ledger-label {
        display: block;
        font-size: 11px;
        font-weight: 600;
        color: #8792a2;
        text-transform: uppercase;
        letter-spacing: 0.4px;
        margin-bottom: 6px;
    }

    #viewLedgerModal .ledger-value {
        display: block;
        font-size: 20px;
        font-weight: 700;
        color: #263445;
        line-height: 1.5;
        min-height: 30px;
        overflow-wrap: anywhere;
    }

    /* ==========================================
       FINANCIAL INFORMATION
    ========================================== */

    #viewLedgerModal .ledger-financial-box {
        background: #fff5f5;
        border: 1px solid #ffd6d6;
        border-radius: 8px;
        padding: 15px;
        min-height: 90px;
    }

    #viewLedgerModal .ledger-financial-box .ledger-label {
        color: #a94442;
    }

    #viewLedgerModal .ledger-outstanding {
        font-size: 20px;
        font-weight: 700;
        color: #dc3545;
    }

    /* ==========================================
       LEASE EXPIRY
    ========================================== */

    #viewLedgerModal .ledger-expiry {
        font-size: 20px;
        font-weight: 700;
        color: #dc3545;
    }

    /* ==========================================
       REMARKS
    ========================================== */

    #viewLedgerModal .ledger-remarks {
        font-size: 20px;
        font-weight: 700;
        color: #b42318;
        white-space: pre-wrap;
        overflow-wrap: anywhere;
    }

    /* ==========================================
       FOOTER
    ========================================== */

    #viewLedgerModal .modal-footer {
        background: #ffffff;
        padding: 14px 22px;
        border-top: 1px solid #e9ecef;
    }

    /* ==========================================
       RESPONSIVE DESIGN
    ========================================== */

    @media (max-width: 768px) {

        #viewLedgerModal .modal-body {
            padding: 12px;
        }

        #viewLedgerModal .ledger-summary {
            padding: 15px;
        }

        #viewLedgerModal .ledger-section-body {
            padding: 15px 15px 0;
        }

        #viewLedgerModal .ledger-summary-name {
            font-size: 22px;
        }

        #viewLedgerModal .ledger-value,
        #viewLedgerModal .ledger-summary-value {
            font-size: 20px;
        }
    }
</style>


<!-- ==========================================
     VIEW LEASE / LEDGER MODAL
========================================== -->

<div class="modal fade effect-scale modal-blur"
     id="viewLedgerModal"
     tabindex="-1"
     aria-labelledby="viewLedgerModalLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">

        <div class="modal-content border-0">

            <!-- =====================================
                 MODAL HEADER
            ====================================== -->

            <div class="modal-header bg-primary text-white">

                <h5 class="modal-title text-white"
                    id="viewLedgerModalLabel">

                    <i class="fas fa-file-contract me-2"></i>
                    Lease / Ledger Details

                </h5>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>

            </div>


            <!-- =====================================
                 MODAL BODY
            ====================================== -->

            <div class="modal-body">


                <!-- =====================================
                     1. LESSEE SUMMARY
                ====================================== -->

                <div class="ledger-summary">

                    <div class="row align-items-center">

                        <div class="col-md-6 mb-3 mb-md-0">

                            <span class="ledger-summary-label">
                                LESSEE / ACCOUNT HOLDER
                            </span>

                            <div class="ledger-summary-name"
                                 id="view_leasee_name">
                                -
                            </div>

                            <span class="ledger-account-badge">
                                Account No:
                                <span id="view_account_number">-</span>
                            </span>

                        </div>

                        <div class="col-md-2 col-6">

                            <span class="ledger-summary-label">
                                PLOT NUMBER
                            </span>

                            <span class="ledger-summary-value"
                                  id="view_plot_number">
                                -
                            </span>

                        </div>

                        <div class="col-md-4 col-6">

                            <span class="ledger-summary-label">
                                ESTATE
                            </span>

                            <span class="ledger-summary-value"
                                  id="view_estate">
                                -
                            </span>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     2. LESSEE CONTACT INFORMATION
                ====================================== -->

                <div class="ledger-section">

                    <div class="ledger-section-header">

                        <i class="fas fa-user-tie"></i>

                        <h6>Lessee Contact Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row">

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Email Address
                                </span>

                                <span class="ledger-value"
                                      id="view_email">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Primary Mobile
                                </span>

                                <span class="ledger-value"
                                      id="view_mobile1">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Secondary Mobile
                                </span>

                                <span class="ledger-value"
                                      id="view_mobile2">-</span>

                            </div>

                            <div class="col-md-8 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Residential Address
                                </span>

                                <span class="ledger-value"
                                      id="view_address">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Digital Address
                                </span>

                                <span class="ledger-value"
                                      id="view_digital_address">-</span>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     3. PROPERTY INFORMATION
                ====================================== -->

                <div class="ledger-section">

                    <div class="ledger-section-header">

                        <i class="fas fa-map-marked-alt"></i>

                        <h6>Property Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row">

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Plot Size (sqm)
                                </span>

                                <span class="ledger-value"
                                      id="view_plot_size">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    LS Number
                                </span>

                                <span class="ledger-value"
                                      id="view_ls_number">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Ledger
                                </span>

                                <span class="ledger-value"
                                      id="view_ledger">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Folio
                                </span>

                                <span class="ledger-value"
                                      id="view_folio">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    File Number
                                </span>

                                <span class="ledger-value"
                                      id="view_file_number">-</span>

                            </div>

                            <div class="col-md-8 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Parcel Address
                                </span>

                                <span class="ledger-value"
                                      id="view_parcel_address">-</span>

                            </div>

                        </div>


                        <hr class="my-2">


                        <div class="row mt-3">

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Covenanted User
                                </span>

                                <span class="ledger-value"
                                      id="view_convenant_user">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Current Use
                                </span>

                                <span class="ledger-value"
                                      id="view_current_use">-</span>

                            </div>

                            <div class="col-md-4 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Nature of Development
                                </span>

                                <span class="ledger-value"
                                      id="view_nature_of_dev">-</span>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     4. LEASE INFORMATION
                ====================================== -->

                <div class="ledger-section">

                    <div class="ledger-section-header">

                        <i class="fas fa-calendar-alt"></i>

                        <h6>Lease Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row">

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Commencement Date
                                </span>

                                <span class="ledger-value"
                                      id="view_commencement_date">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Lease Term (Years)
                                </span>

                                <span class="ledger-value"
                                      id="view_term">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Expiry Date
                                </span>

                                <span class="ledger-value ledger-expiry"
                                      id="view_expiry_date">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Nature of Instrument
                                </span>

                                <span class="ledger-value"
                                      id="view_nature_of_instrument">-</span>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     5. RENT INFORMATION
                ====================================== -->

                <div class="ledger-section">

                    <div class="ledger-section-header">

                        <i class="fas fa-money-bill-wave"></i>

                        <h6>Rent Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row">

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Rent Category
                                </span>

                                <span class="ledger-value"
                                      id="view_rent_category">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Rent Passing
                                </span>

                                <span class="ledger-value"
                                      id="view_rent_passing">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Location Rate
                                </span>

                                <span class="ledger-value"
                                      id="view_location_rate">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Rent Review Clause
                                </span>

                                <span class="ledger-value"
                                      id="view_rent_review_clause">-</span>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     6. PAYMENT INFORMATION
                ====================================== -->

                <div class="ledger-section">

                    <div class="ledger-section-header">

                        <i class="fas fa-chart-line"></i>

                        <h6>Payment & Arrears Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row align-items-stretch">

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Last Payment Date
                                </span>

                                <span class="ledger-value"
                                      id="view_last_payment_date">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Last Payment Period
                                </span>

                                <span class="ledger-value"
                                      id="view_last_payment_period">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 ledger-field">

                                <span class="ledger-label">
                                    Periods in Arrears
                                </span>

                                <span class="ledger-value"
                                      id="view_period_in_arrears">-</span>

                            </div>

                            <div class="col-md-3 col-sm-6 mb-3">

                                <div class="ledger-financial-box">

                                    <span class="ledger-label">
                                        RENT OUTSTANDING
                                    </span>

                                    <span class="ledger-value ledger-outstanding"
                                          id="view_rent_outstanding">-</span>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     7. ADDITIONAL INFORMATION
                ====================================== -->

                <div class="ledger-section mb-0">

                    <div class="ledger-section-header">

                        <i class="fas fa-info-circle"></i>

                        <h6>Additional Information</h6>

                    </div>

                    <div class="ledger-section-body">

                        <div class="row">

                            <div class="col-md-4 ledger-field">

                                <span class="ledger-label">
                                    GLPIN
                                </span>

                                <span class="ledger-value"
                                      id="view_glpin">-</span>

                            </div>

                            <div class="col-md-8 ledger-field">

                                <span class="ledger-label">
                                    Remarks
                                </span>

                                <span class="ledger-value ledger-remarks"
                                      id="view_remarks">-</span>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- =====================================
                 MODAL FOOTER
            ====================================== -->

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-outline-secondary"
                        data-bs-dismiss="modal">

                    <i class="fas fa-times me-1"></i>
                    Close

                </button>

            </div>

        </div>

    </div>

</div>


<!-- Transaction History Modal -->
<div class="modal fade" data-position="0" id="transactionhistory" tabindex="-1" aria-labelledby="transactionhistoryLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="transactionhistoryLabel">Transaction History</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning mb-2 d-none" id="xloadRt" onclick="loadTransactionHistory()"><i class="fa fa-undo"></i></button>
				<button class="btn btn-danger btn-sm mb-2 d-none" id="btnAddNewLessee" data-bs-toggle="modal" data-bs-target="#addlegder">Add New Lessee</button>
				<!-- <button class="btn btn-success btn-sm mb-2" id="btnAddTransaction" data-bs-toggle="collapse" data-bs-target="#addtransactiondiv">Add Transaction</button> -->
				 <input id="parcel_idxxxx" type="hidden" />
				<div class="row d-none" id="exDatar">
					<div class="col-md-6">
						<label for="xxr_glpin" class="form-label">GLPIN: </label>
						<input type="text" class="form-control" id="xxr_glpin" readonly>
					</div>
					<div class="col-md-6">
						<label for="xxr_plot_size" class="form-label">Land Size: </label>
						<input type="text" class="form-control" id="xxr_plot_size" readonly/>
					</div>
					<div class="col-md-6">
						<label for="xxr_locality" class="form-label">Locality: </label>
						<input type="text" class="form-control" id="xxr_locality" readonly/>
					</div>
				</div>
				<div class="table-responsive small mt-2">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_parcel_transaction_history" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Plot Number</th>
								<th>Name of Lessee</th>
								<th>Nature of Interest</th>
								<th>Consent Date</th>
								<th>Term</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Rent Parcel Details Modal -->
<div class="modal fade" data-position="0" id="rentParcelDetails" tabindex="-1" aria-labelledby="rentParcelDetailsLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rentParcelDetailsLabel">Parcel Details</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-success btn-sm mb-2" data-bs-toggle="collapse" data-bs-target="#addlegderCollapse">Add New Lessee</button>
				<div class="collapse mb-2" id="addlegderCollapse">
					<div class="card card-body">
						<input id="rt_rent_id" value="0" type="hidden"/>
						<div class="row">
							<div class="col-6">
								<div class="mb-2">
									<label for="pd_gep_glpin" class="form-label">Developed: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_glpin" required/>
								</div>
								<div class="mb-2">
									<label for="pd_gep_glpin2" class="form-label">GLPIN.: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_glpin2" required/>
								</div>
							</div>
							<div class="col-6">
								<div class="mb-2">
									<label for="pd_gep_locality" class="form-label">Locality: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_locality" required />
								</div>
								<div class="mb-2">
									<label for="pd_gep_land_size" class="form-label">Land Size: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_land_size" required/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_parcel_details" width="100%" cellspacing="0">
						  <thead class="small">
                            <tr>
                                <th>Plot Number</th>
                                <th>Name of Lessee</th>
                                <th>File Number</th>
                                <th>Commencement Date</th>
                                <th>Consent Date</th>
                                <th>Term</th>
                                <th>Plot Size</th>
                                <th>Rent Review Period</th>
                                <th>Last Payment Period</th>
                                <th>Rent Outstanding</th>
                                <th>Unexpired Term</th>
                                <th>Action</th>
                            </tr>
                        </thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<style>
/* =====================================================
   ELIS RENT MANAGEMENT - ADD / EDIT MODALS
===================================================== */

#addlegder,
#editlegder {
    --elis-primary: #3656c8;
    --elis-edit: #087f8c;
    --elis-border: #e4e9f2;
    --elis-background: #f5f7fc;
    --elis-text: #263449;
    --elis-muted: #778397;
}

#addlegder .modal-dialog,
#editlegder .modal-dialog {
    max-width: 1120px;
}

#addlegder .modal-content,
#editlegder .modal-content {
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(22, 38, 75, .16);
}

/* HEADER */

#addlegder .elis-modal-header,
#editlegder .elis-modal-header {
    padding: 22px 28px;
    border: 0;
    color: #fff;
}

#addlegder .elis-modal-header {
    background: linear-gradient(120deg, #263fa5, #5276e5);
}

#editlegder .elis-modal-header {
    background: linear-gradient(120deg, #075e68, #12a0a9);
}

.elis-header-icon {
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    background: rgba(255,255,255,.18);
    font-size: 21px;
}

.elis-header-title {
    font-size: 21px;
    font-weight: 700;
    margin: 0;
}

.elis-header-subtitle {
    font-size: 12px;
    opacity: .85;
    margin-top: 5px;
}

/* BODY */

#addlegder .modal-body,
#editlegder .modal-body {
    background: var(--elis-background);
    padding: 24px;
}

/* NAVIGATION */

.elis-form-nav {
    display: flex;
    gap: 8px;
    overflow-x: auto;
    padding: 4px 0 16px;
    margin-bottom: 12px;
    scrollbar-width: thin;
}

.elis-nav-item {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 15px;
    background: #fff;
    border: 1px solid var(--elis-border);
    border-radius: 9px;
    color: #56647a;
    font-size: 12px;
    font-weight: 600;
    text-decoration: none;
    white-space: nowrap;
    transition: .2s;
}

.elis-nav-item:hover {
    color: var(--elis-primary);
    border-color: var(--elis-primary);
    background: #eef2ff;
}

/* SECTION */

.elis-form-section {
    background: #fff;
    border: 1px solid var(--elis-border);
    border-radius: 13px;
    margin-bottom: 20px;
    overflow: hidden;
    scroll-margin-top: 16px;
}

.elis-section-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 17px 20px;
    border-bottom: 1px solid #edf0f5;
}

.elis-section-number {
    width: 33px;
    height: 33px;
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #edf1ff;
    color: #3656c8;
    font-weight: 800;
    font-size: 13px;
    flex-shrink: 0;
}

.elis-section-title {
    font-size: 15px;
    font-weight: 700;
    color: #263449;
    margin: 0;
}

.elis-section-description {
    font-size: 12px;
    color: #8993a5;
    margin-top: 3px;
}

.elis-section-body {
    padding: 22px 20px;
}

/* INPUTS */

#addlegder .form-label,
#editlegder .form-label {
    font-size: 12px;
    font-weight: 700;
    color: #46546b;
    margin-bottom: 8px;
}

#addlegder .form-control,
#addlegder .form-select,
#editlegder .form-control,
#editlegder .form-select {
    min-height: 45px;
    border-radius: 8px;
    border: 1px solid #dce3ed;
    font-size: 14px;
    font-weight: 500;
    color: #263449;
    padding: 10px 13px;
    transition: .2s;
}

#addlegder textarea.form-control,
#editlegder textarea.form-control {
    min-height: 82px;
    resize: vertical;
}

#addlegder .form-control:focus,
#addlegder .form-select:focus {
    border-color: #5276e5;
    box-shadow: 0 0 0 3px rgba(82,118,229,.12);
}

#editlegder .form-control:focus,
#editlegder .form-select:focus {
    border-color: #12a0a9;
    box-shadow: 0 0 0 3px rgba(18,160,169,.12);
}

#addlegder .input-group-text,
#editlegder .input-group-text {
    background: #f2f5fa;
    border-color: #dce3ed;
    color: #64748b;
    font-size: 13px;
    font-weight: 700;
}

#addlegder .input-group > .form-control,
#editlegder .input-group > .form-control {
    min-width: 0;
}

#addlegder .form-control[readonly],
#editlegder .form-control[readonly] {
    background: #eef2f7;
    color: #64748b;
}

.elis-required {
    color: #dc3545;
    font-weight: 800;
}

.elis-field-hint {
    display: block;
    margin-top: 6px;
    font-size: 11px;
    color: #8b96a8;
}

/* FINANCIAL FIELDS */

.elis-money-field {
    background: #f8fafc;
    border-radius: 10px;
    padding: 15px;
    border: 1px solid #e6ebf3;
    height: 100%;
}

.elis-money-field.danger {
    background: #fff5f5;
    border-color: #ffd8d8;
}

.elis-money-field.danger .form-control {
    color: #c92a2a !important;
    font-weight: 700 !important;
}

/* FOOTER */

#addlegder .modal-footer,
#editlegder .modal-footer {
    padding: 17px 24px;
    background: #fff;
    border-top: 1px solid #e8edf4;
    gap: 10px;
}

.elis-footer-note {
    margin-right: auto;
    font-size: 12px;
    color: #8b96a8;
}

.elis-save-btn {
    padding: 11px 25px;
    border-radius: 8px;
    font-weight: 700;
    font-size: 13px;
}

.elis-cancel-btn {
    padding: 11px 22px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 13px;
}

/* MOBILE */

@media(max-width:768px) {

    #addlegder .modal-body,
    #editlegder .modal-body {
        padding: 13px;
    }

    .elis-section-body {
        padding: 16px;
    }

    .elis-header-title {
        font-size: 17px;
    }

    .elis-footer-note {
        display: none;
    }
}

/* Make modal titles white */
#addlegder .elis-header-title,
#editlegder .elis-header-title {
    color: #ffffff !important;
    font-size: 21px;
    font-weight: 700;
}

/* Make modal subtitles white */
#addlegder .elis-header-subtitle,
#editlegder .elis-header-subtitle {
    color: #ffffff !important;
    opacity: 0.9;
}

/* Make header icons white */
#addlegder .elis-header-icon,
#editlegder .elis-header-icon {
    color: #ffffff !important;
}
/* ==========================================
   GREEN GRADIENT MODAL HEADERS
========================================== */

#addlegder .elis-modal-header,
#editlegder .elis-modal-header {
    background: linear-gradient(
        135deg,
        #065f46 0%,
        #059669 50%,
        #10b981 100%
    ) !important;

    color: #ffffff !important;
    padding: 22px 28px;
    border: none;
}

/* Modal titles */
#addlegder .elis-header-title,
#editlegder .elis-header-title {
    color: #ffffff !important;
    font-size: 21px;
    font-weight: 700;
}

/* Modal subtitles */
#addlegder .elis-header-subtitle,
#editlegder .elis-header-subtitle {
    color: #ffffff !important;
    opacity: 0.9;
}

/* Header icon */
#addlegder .elis-header-icon,
#editlegder .elis-header-icon {
    background: rgba(255, 255, 255, 0.18);
    color: #ffffff !important;
}

/* Close button */
#addlegder .btn-close,
#editlegder .btn-close {
    filter: brightness(0) invert(1);
    opacity: 0.9;
}
</style>


<!-- =====================================================
     ADD LESSEE MODAL
===================================================== -->

<div class="modal fade effect-fade modal-blur"
     id="addlegder"
     tabindex="-1"
     aria-labelledby="addlegderLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">

        <div class="modal-content border-0">

            <!-- HEADER -->

            <div class="modal-header elis-modal-header">

                <div class="d-flex align-items-center gap-3">

                    <div class="elis-header-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>

                    <div>
                        <h5 class="elis-header-title" id="addlegderLabel">
                            Add New Lessee / Lease
                        </h5>

                        <div class="elis-header-subtitle">
                            Register lessee, property, lease and rent information
                        </div>
                    </div>

                </div>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>

            </div>


            <!-- BODY -->

            <div class="modal-body">

                <form id="addlegderForm"
                      class="needs-validation"
                      novalidate>

                    <input type="hidden"
                           id="rt_rent_id"
                           class="rt_rent_id"
                           value="0">

                    <input type="hidden"
                           id="rt_parcel_id"
                           value="0">


                    <!-- SECTION NAVIGATION -->

                    <div class="elis-form-nav">

                        <a href="#add-lessee-section" class="elis-nav-item">
                            <i class="fas fa-user"></i> Lessee
                        </a>

                        <a href="#add-property-section" class="elis-nav-item">
                            <i class="fas fa-map-marked-alt"></i> Property
                        </a>

                        <a href="#add-lease-section" class="elis-nav-item">
                            <i class="fas fa-file-contract"></i> Lease
                        </a>

                        <a href="#add-rent-section" class="elis-nav-item">
                            <i class="fas fa-money-bill-wave"></i> Rent
                        </a>

                        <a href="#add-payment-section" class="elis-nav-item">
                            <i class="fas fa-history"></i> Payment
                        </a>

                    </div>


                    <!-- =====================================
                         SECTION 1 - LESSEE
                    ====================================== -->

                    <div class="elis-form-section"
                         id="add-lessee-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">01</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Lessee Information
                                </h6>

                                <div class="elis-section-description">
                                    Personal and contact details of the lessee
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_leasee_name" class="form-label">
                                        Full Name
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_leasee_name"
                                           placeholder="Enter lessee full name"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter lessee's full name.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_email" class="form-label">
                                        Email Address
                                    </label>

                                    <input type="email"
                                           class="form-control"
                                           id="rt_email"
                                           placeholder="example@email.com">

                                    <div class="invalid-feedback">
                                        Please enter a valid email address.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_mobile_phone_1" class="form-label">
                                        Primary Mobile
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <span class="input-group-text">
                                            +233
                                        </span>

                                        <input type="tel"
                                               class="form-control"
                                               id="rt_mobile_phone_1"
                                               placeholder="0241234567"
                                               pattern="[0-9]{10}"
                                               required>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter a valid 10-digit mobile number.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_mobile_phone_2" class="form-label">
                                        Secondary Mobile
                                    </label>

                                    <div class="input-group">

                                        <span class="input-group-text">
                                            +233
                                        </span>

                                        <input type="tel"
                                               class="form-control"
                                               id="rt_mobile_phone_2"
                                               placeholder="Optional"
                                               pattern="[0-9]{10}">

                                    </div>

                                </div>


                                <div class="col-md-8">

                                    <label for="rt_leasee_address" class="form-label">
                                        Postal / Residential Address
                                        <span class="elis-required">*</span>
                                    </label>

                                    <textarea class="form-control"
                                              id="rt_leasee_address"
                                              rows="2"
                                              placeholder="Enter postal or residential address"
                                              required></textarea>

                                    <div class="invalid-feedback">
                                        Please enter postal address.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_leasee_digital_address" class="form-label">
                                        Digital Address
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_leasee_digital_address"
                                           placeholder="GA-123-4567">

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         SECTION 2 - PROPERTY
                    ====================================== -->

                    <div class="elis-form-section"
                         id="add-property-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">02</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Property Information
                                </h6>

                                <div class="elis-section-description">
                                    Parcel identification, land use and registration details
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-4">

                                    <label for="rt_plot_number" class="form-label">
                                        Plot Number
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_plot_number"
                                           placeholder="Plot number"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter plot number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_plot_size" class="form-label">
                                        Plot Size
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <input type="number"
                                               class="form-control"
                                               id="rt_plot_size"
                                               step="0.01"
                                               min="0"
                                               placeholder="0.00"
                                               required>

                                        <span class="input-group-text">
                                            Acres
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter plot size.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_glpin" class="form-label">
                                        GLPIN
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_glpin"
                                           placeholder="Enter GLPIN">

                                </div>


                                <div class="col-md-8">

                                    <label for="rt_parcel_address" class="form-label">
                                        Parcel Address
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_parcel_address"
                                           placeholder="Enter property location">

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_ls_number" class="form-label">
                                        LS Number
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_ls_number"
                                           placeholder="LS number">

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_convenant_user" class="form-label">
                                        Covenanted User
                                    </label>

                                    <select class="form-select"
                                            id="rt_convenant_user">

                                        <option value="">Select use</option>

                                        <c:forEach items="${user_category_list}"
                                                   var="usercategorylist">

                                            <option value="${usercategorylist.us_name}">
                                                ${usercategorylist.us_name}
                                            </option>

                                        </c:forEach>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_current_use" class="form-label">
                                        Current Use
                                    </label>

                                    <select class="form-select"
                                            id="rt_current_use">

                                        <option value="">Select use</option>

                                        <c:forEach items="${user_category_list}"
                                                   var="usercategorylist">

                                            <option value="${usercategorylist.us_name}">
                                                ${usercategorylist.us_name}
                                            </option>

                                        </c:forEach>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_nature_of_dev" class="form-label">
                                        Nature of Development
                                    </label>

                                    <select class="form-select"
                                            id="rt_nature_of_dev">

                                        <option value="">Loading...</option>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_file_number" class="form-label">
                                        File Number
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_file_number"
                                           placeholder="File reference"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter file number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_ledger" class="form-label">
                                        Ledger
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_ledger"
                                           placeholder="Ledger number"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter ledger number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_folio" class="form-label">
                                        Folio
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_folio"
                                           placeholder="Folio number">

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         SECTION 3 - LEASE
                    ====================================== -->

                    <div class="elis-form-section"
                         id="add-lease-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">03</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Lease & Tenure Information
                                </h6>

                                <div class="elis-section-description">
                                    Estate, instrument and lease duration
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_estate" class="form-label">
                                        Estate
                                        <span class="elis-required">*</span>
                                    </label>

                                    <select class="form-select"
                                            id="rt_estate"
                                            required>

                                        <option value="">Loading estates...</option>

                                    </select>

                                    <div class="invalid-feedback">
                                        Please select an estate.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_nature_of_instrument" class="form-label">
                                        Nature of Instrument
                                    </label>

                                    <select class="form-select"
                                            id="rt_nature_of_instrument">

                                        <option value="">Loading instruments...</option>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_commencement_date" class="form-label">
                                        Commencement Date
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_commencement_date"
                                           required>

                                    <div class="invalid-feedback">
                                        Please select commencement date.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_term" class="form-label">
                                        Lease Term
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <input type="number"
                                               class="form-control"
                                               id="rt_term"
                                               min="1"
                                               max="999"
                                               placeholder="99"
                                               required>

                                        <span class="input-group-text">
                                            Years
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter lease term.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_expiry_date" class="form-label">
                                        Expiry Date
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_expiry_date"
                                           readonly>

                                    <span class="elis-field-hint">
                                        Calculated from commencement date and term
                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         SECTION 4 - RENT
                    ====================================== -->

                    <div class="elis-form-section"
                         id="add-rent-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">04</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Rent Terms
                                </h6>

                                <div class="elis-section-description">
                                    Rent category, annual rent and review conditions
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_rent_category" class="form-label">
                                        Rent Category
                                    </label>

                                    <select class="form-select"
                                            id="rt_rent_category">

                                        <option value="">Select category</option>
                                        <option value="Economic Rent">Economic Rent</option>
                                        <option value="Subsidized Rent">Subsidized Rent</option>
                                        <option value="Peppercorn Rent">Peppercorn Rent</option>
                                        <option value="Commercial Rent">Commercial Rent</option>

                                    </select>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_rent_review_clause" class="form-label">
                                        Rent Review Period
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <input type="number"
                                               class="form-control"
                                               id="rt_rent_review_clause"
                                               min="0"
                                               value="0"
                                               required>

                                        <span class="input-group-text">
                                            Years
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter rent review period.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <div class="elis-money-field">

                                        <label for="rt_rent_passing" class="form-label">
                                            Rent Passing (GHS)
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_rent_passing"
                                                   step="0.01"
                                                   min="0"
                                                   value="0">

                                        </div>

                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <div class="elis-money-field">

                                        <label for="rt_location_rate" class="form-label">
                                            Location Rate (GHS)
                                            <span class="elis-required">*</span>
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_location_rate"
                                                   step="0.01"
                                                   min="0"
                                                   value="0.00"
                                                   required>

                                        </div>

                                        <div class="invalid-feedback">
                                            Please enter location rate.
                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         SECTION 5 - PAYMENT
                    ====================================== -->

                    <div class="elis-form-section"
                         id="add-payment-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">05</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Payment & Arrears Information
                                </h6>

                                <div class="elis-section-description">
                                    Historical payment details and outstanding rent
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_last_payment_date" class="form-label">
                                        Last Payment Date
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_last_payment_date"
                                           required>

                                    <div class="invalid-feedback">
                                        Please select last payment date.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_last_payment_period" class="form-label">
                                        Last Payment Period
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_last_payment_period"
                                           value="0"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter last payment period.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_period_in_arrears" class="form-label">
                                        Periods in Arrears
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="number"
                                           class="form-control"
                                           id="rt_period_in_arrears"
                                           min="0"
                                           value="0"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter periods in arrears.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <div class="elis-money-field danger">

                                        <label for="rt_rent_outstanding" class="form-label">
                                            Rent Outstanding (GHS)
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_rent_outstanding"
                                                   step="0.01"
                                                   min="0"
                                                   value="0">

                                        </div>

                                    </div>

                                </div>


                                <div class="col-md-12">

                                    <label for="rt_remarks" class="form-label">
                                        Remarks / Additional Notes
                                    </label>

                                    <textarea class="form-control"
                                              id="rt_remarks"
                                              rows="3"
                                              placeholder="Enter additional information or remarks"></textarea>

                                </div>

                            </div>

                        </div>

                    </div>

                </form>

            </div>


            <!-- FOOTER -->

            <div class="modal-footer">

                <span class="elis-footer-note">
                    <i class="fas fa-info-circle me-1"></i>
                    Fields marked * are required
                </span>

                <button type="button"
                        class="btn btn-outline-secondary elis-cancel-btn"
                        data-bs-dismiss="modal">

                    <i class="fas fa-times me-1"></i>
                    Cancel

                </button>

                <button type="button"
                        class="btn btn-primary elis-save-btn"
                        id="btn_save_rent_client_details">

                    <i class="fas fa-save me-1"></i>
                    Save Lessee Details

                </button>

            </div>

        </div>

    </div>

</div>

<!-- =====================================================
     EDIT LESSEE MODAL
===================================================== -->

<div class="modal fade effect-fade modal-blur"
     id="editlegder"
     tabindex="-1"
     aria-labelledby="editlegderLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">

        <div class="modal-content border-0">

            <!-- HEADER -->

            <div class="modal-header elis-modal-header">

                <div class="d-flex align-items-center gap-3">

                    <div class="elis-header-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>

                    <div>

                        <h5 class="elis-header-title" id="editlegderLabel">
                            Edit Lessee / Lease Details
                        </h5>

                        <div class="elis-header-subtitle">
                            Update existing lessee, property and lease information
                        </div>

                    </div>

                </div>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>

            </div>


            <!-- BODY -->

            <div class="modal-body">

                <form id="editlegderForm"
                      class="needs-validation"
                      novalidate>

                    <input type="hidden"
                           id="rt_e_rent_id"
                           class="rt_e_rent_id"
                           value="0">

                    <!-- Unique edit parcel ID -->
                    <input type="hidden"
                           id="rt_e_parcel_id"
                           value="0">


                    <!-- NAVIGATION -->

                    <div class="elis-form-nav">

                        <a href="#edit-lessee-section" class="elis-nav-item">
                            <i class="fas fa-user"></i> Lessee
                        </a>

                        <a href="#edit-property-section" class="elis-nav-item">
                            <i class="fas fa-map-marked-alt"></i> Property
                        </a>

                        <a href="#edit-lease-section" class="elis-nav-item">
                            <i class="fas fa-file-contract"></i> Lease
                        </a>

                        <a href="#edit-rent-section" class="elis-nav-item">
                            <i class="fas fa-money-bill-wave"></i> Rent
                        </a>

                        <a href="#edit-payment-section" class="elis-nav-item">
                            <i class="fas fa-history"></i> Payment
                        </a>

                    </div>


                    <!-- =====================================
                         1. LESSEE INFORMATION
                    ====================================== -->

                    <div class="elis-form-section" id="edit-lessee-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">01</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Lessee Information
                                </h6>

                                <div class="elis-section-description">
                                    Update lessee contact and personal details
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_e_leasee_name" class="form-label">
                                        Full Name
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_leasee_name"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter lessee's full name.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_e_email" class="form-label">
                                        Email Address
                                    </label>

                                    <input type="email"
                                           class="form-control"
                                           id="rt_e_email">

                                    <div class="invalid-feedback">
                                        Please enter a valid email address.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_e_mobile_phone_1" class="form-label">
                                        Primary Mobile
                                        <!-- <span class="elis-required">*</span> -->
                                    </label>

                                    <div class="input-group">

                                        <span class="input-group-text">
                                            +233
                                        </span>

                                        <input type="tel"
                                               class="form-control"
                                               id="rt_e_mobile_phone_1"
                                               pattern="[0-9]{10}">
                                               <!-- required -->

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter a valid 10-digit mobile number.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_e_mobile_phone_2" class="form-label">
                                        Secondary Mobile
                                    </label>

                                    <div class="input-group">

                                        <span class="input-group-text">
                                            +233
                                        </span>

                                        <input type="tel"
                                               class="form-control"
                                               id="rt_e_mobile_phone_2"
                                               pattern="[0-9]{10}">

                                    </div>

                                </div>


                                <div class="col-md-8">

                                    <label for="rt_e_leasee_address" class="form-label">
                                        Postal / Residential Address
                                        <span class="elis-required">*</span>
                                    </label>

                                    <textarea class="form-control"
                                              id="rt_e_leasee_address"
                                              rows="2"
                                              required></textarea>

                                    <div class="invalid-feedback">
                                        Please enter postal address.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_leasee_digital_address" class="form-label">
                                        Digital Address
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_leasee_digital_address">

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         2. PROPERTY INFORMATION
                    ====================================== -->

                    <div class="elis-form-section" id="edit-property-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">02</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Property Information
                                </h6>

                                <div class="elis-section-description">
                                    Update parcel identification and land use
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-4">

                                    <label for="rt_e_plot_number" class="form-label">
                                        Plot Number
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_plot_number"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter plot number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_plot_size" class="form-label">
                                        Plot Size
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                                                                <input type="number"
                                            class="form-control"
                                            id="rt_e_plot_size"
                                            name="rt_e_plot_size"
                                            step="any"
                                            min="0"
                                            placeholder="0.00"
                                            onblur="if(this.value !== '' && this.validity.valid) this.value = Number(this.value).toFixed(2)"
                                            required>

                                        <span class="input-group-text">
                                            Acres
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter plot size.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_glpin" class="form-label">
                                        GLPIN
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_glpin">

                                </div>


                                <div class="col-md-8">

                                    <label for="rt_e_parcel_address" class="form-label">
                                        Parcel Address
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_parcel_address">

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_ls_number" class="form-label">
                                        LS Number
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_ls_number">

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_convenant_user" class="form-label">
                                        Covenanted User
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_convenant_user">

                                        <option value="">Select use</option>

                                        <c:forEach items="${user_category_list}"
                                                   var="usercategorylist">

                                            <option value="${usercategorylist.us_name}">
                                                ${usercategorylist.us_name}
                                            </option>

                                        </c:forEach>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_current_use" class="form-label">
                                        Current Use
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_current_use">

                                        <option value="">Select use</option>

                                        <c:forEach items="${user_category_list}"
                                                   var="usercategorylist">

                                            <option value="${usercategorylist.us_name}">
                                                ${usercategorylist.us_name}
                                            </option>

                                        </c:forEach>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_nature_of_dev" class="form-label">
                                        Nature of Development
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_nature_of_dev">

                                        <option value="">Loading...</option>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_file_number" class="form-label">
                                        File Number
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_file_number"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter file number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_ledger" class="form-label">
                                        Ledger
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_ledger"
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter ledger number.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_folio" class="form-label">
                                        Folio
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_folio">

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         3. LEASE INFORMATION
                    ====================================== -->

                    <div class="elis-form-section" id="edit-lease-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">03</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Lease & Tenure Information
                                </h6>

                                <div class="elis-section-description">
                                    Update estate, instrument and lease duration
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <!-- <div class="col-md-6">

                                    <label for="rt_e_estate" class="form-label">
                                        Estate
                                        <span class="elis-required">*</span>
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_estate"
                                            required>

                                        <option value="">Loading estates...</option>

                                    </select>

                                    <div class="invalid-feedback">
                                        Please select an estate.
                                    </div>

                                </div> -->


                                <div class="col-md-6">

                                    <label for="rt_e_nature_of_instrument" class="form-label">
                                        Nature of Instrument
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_nature_of_instrument">

                                        <option value="">Loading instruments...</option>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_commencement_date" class="form-label">
                                        Commencement Date
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_e_commencement_date"
                                           required>

                                    <div class="invalid-feedback">
                                        Please select commencement date.
                                    </div>

                                </div>


                                <div class="col-md-2">

                                    <label for="rt_e_term" class="form-label">
                                        Lease Term
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <input type="number"
                                               class="form-control"
                                               id="rt_e_term"
                                               min="1"
                                               max="999"
                                               required>

                                        <span class="input-group-text">
                                            Years
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter lease term.
                                    </div>

                                </div>


                                <!-- <div class="col-md-4">

                                    <label for="rt_e_expiry_date" class="form-label">
                                        Expiry Date
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_e_expiry_date"
                                           readonly>

                                    <span class="elis-field-hint">
                                        Automatically calculated
                                    </span>

                                </div> -->

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         4. RENT INFORMATION
                    ====================================== -->

                    <div class="elis-form-section" id="edit-rent-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">04</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Rent Terms
                                </h6>

                                <div class="elis-section-description">
                                    Update rent category, rates and review period
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-4">

                                    <label for="rt_e_rent_category" class="form-label">
                                        Rent Category
                                    </label>

                                    <select class="form-select"
                                            id="rt_e_rent_category">

                                        <option value="">Select category</option>
                                        <option value="Economic Rent">Economic Rent</option>
                                        <option value="Subsidized Rent">Subsidized Rent</option>
                                        <option value="Peppercorn Rent">Peppercorn Rent</option>
                                        <option value="Ground Rent">Ground Rent</option>
                                        <option value="Commercial Rent">Commercial Rent</option>

                                    </select>

                                </div>


                                <div class="col-md-4">

                                    <label for="rt_e_rent_review_clause" class="form-label">
                                        Rent Review Period
                                        <span class="elis-required">*</span>
                                    </label>

                                    <div class="input-group">

                                        <input type="number"
                                               class="form-control"
                                               id="rt_e_rent_review_clause"
                                               min="0"
                                               value="0"
                                               required>

                                        <span class="input-group-text">
                                            Years
                                        </span>

                                    </div>

                                    <div class="invalid-feedback">
                                        Please enter rent review period.
                                    </div>

                                </div>


                                <div class="col-md-4">

                                    <div class="elis-money-field">

                                        <label for="rt_e_rent_passing" class="form-label">
                                            Rent Passing (GHS)
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_e_rent_passing"
                                                   step="0.01"
                                                   min="0"
                                                   value="0">

                                        </div>

                                    </div>

                                </div>


                                <!-- <div class="col-md-6">

                                    <div class="elis-money-field">

                                        <label for="rt_e_location_rate" class="form-label">
                                            Location Rate (GHS)
                                            <span class="elis-required">*</span>
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_e_location_rate"
                                                   step="0.01"
                                                   min="0"
                                                   value="0.00"
                                                   required>

                                        </div>

                                        <div class="invalid-feedback">
                                            Please enter location rate.
                                        </div>

                                    </div>

                                </div> -->

                            </div>

                        </div>

                    </div>


                    <!-- =====================================
                         5. PAYMENT INFORMATION
                    ====================================== -->

                    <div class="elis-form-section" id="edit-payment-section">

                        <div class="elis-section-header">

                            <div class="elis-section-number">05</div>

                            <div>
                                <h6 class="elis-section-title">
                                    Payment & Arrears Information
                                </h6>

                                <div class="elis-section-description">
                                    Update historical payments and outstanding balances
                                </div>
                            </div>

                        </div>

                        <div class="elis-section-body">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <label for="rt_e_last_payment_date" class="form-label">
                                        Last Payment Date
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="date"
                                           class="form-control"
                                           id="rt_e_last_payment_date"
                                           required>

                                    <div class="invalid-feedback">
                                        Please select last payment date.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_e_last_payment_period" class="form-label">
                                        Last Payment Period
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_last_payment_period"
                                    
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter last payment period.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <label for="rt_e_period_in_arrears" class="form-label">
                                        Periods in Arrears
                                        <span class="elis-required">*</span>
                                    </label>

                                    <input type="text"
                                           class="form-control"
                                           id="rt_e_period_in_arrears"
                                          
                                           required>

                                    <div class="invalid-feedback">
                                        Please enter periods in arrears.
                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <div class="elis-money-field danger">

                                        <label for="rt_e_rent_outstanding" class="form-label">
                                            Rent Outstanding (GHS)
                                        </label>

                                        <div class="input-group">

                                            <span class="input-group-text">
                                                GHS
                                            </span>

                                            <input type="number"
                                                   class="form-control"
                                                   id="rt_e_rent_outstanding"
                                                   step="0.01"
                                                   min="0"
                                                   value="0">

                                        </div>

                                    </div>

                                </div>


                                <div class="col-md-12">

                                    <label for="rt_e_remarks" class="form-label">
                                        Remarks / Additional Notes
                                    </label>

                                    <textarea class="form-control"
                                              id="rt_e_remarks"
                                              rows="3"
                                              placeholder="Enter remarks"></textarea>

                                </div>

                            </div>

                        </div>

                    </div>

                </form>

            </div>


            <!-- FOOTER -->

            <div class="modal-footer">

                <span class="elis-footer-note">
                    <i class="fas fa-info-circle me-1"></i>
                    Review changes before saving
                </span>

                <button type="button"
                        class="btn btn-outline-secondary elis-cancel-btn"
                        data-bs-dismiss="modal">

                    <i class="fas fa-times me-1"></i>
                    Cancel

                </button>

                <button type="button"
                        class="btn btn-success elis-save-btn"
                        id="btn_save_edit_rent_client_details">

                    <i class="fas fa-check-circle me-1"></i>
                    Update Lease Details

                </button>

            </div>

        </div>

    </div>

</div>

<!-- View Ledger Modal -->
<div class="modal fade" id="viewLedger" tabindex="-1" aria-labelledby="viewLedgerLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewLedgerLabel">Lessee Details</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- Lessee Details -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Lessee's Details
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-6 mb-2">
								<strong>Name:</strong> <span id="view_leasee_name"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Email:</strong> <span id="view_email"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Postal Address:</strong> <span id="view_address"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Digital Address:</strong> <span id="view_digital_address"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Mobile 1:</strong> <span id="view_mobile1"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Mobile 2:</strong> <span id="view_mobile2"></span>
							</div>
						</div>
					</div>
				</div>

				<!-- Parcel Details -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Parcel's Details
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-6 mb-2">
								<strong>Plot Number:</strong> <span id="view_plot_number"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Plot Size:</strong> <span id="view_plot_size"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>File Number:</strong> <span id="view_file_number"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Ledger:</strong> <span id="view_ledger"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Folio:</strong> <span id="view_folio"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>LS Number:</strong> <span id="view_ls_number"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Convenanted User:</strong> <span id="view_convenant_user"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Parcel Address:</strong> <span id="view_parcel_address"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Current User:</strong> <span id="view_current_use"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Nature of Development:</strong> <span id="view_nature_of_dev"></span>
							</div>
						</div>
					</div>
				</div>

				<!-- Tenure Information -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Tenure Information
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-6 mb-2">
								<strong>Estate:</strong> <span id="view_estate"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Commencement Date:</strong> <span id="view_commencement_date"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Term:</strong> <span id="view_term"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Nature of Instrument:</strong> <span id="view_nature_of_instrument"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Expire Date:</strong> <span id="view_expiry_date"></span>
							</div>
						</div>
					</div>
				</div>

				<!-- Rent Terms -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Rent Terms
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-6 mb-2">
								<strong>Rent Category:</strong> <span id="view_rent_category"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Rent Passing:</strong> <span id="view_rent_passing"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Location Rate:</strong> <span id="view_location_rate"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Rent Revision Period:</strong> <span id="view_rent_review_clause"></span>
							</div>
						</div>
					</div>
				</div>

				<!-- Payment History -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Payment History
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-6 mb-2">
								<strong>Last Payment Date:</strong> <span id="view_last_payment_date"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Last Payment Period:</strong> <span id="view_last_payment_period"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Outstanding Rent:</strong> <span id="view_rent_outstanding"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Period In Arrears:</strong> <span id="view_period_in_arrears"></span>
							</div>
							<div class="col-6 mb-2">
								<strong>Remarks:</strong> <span id="view_remarks"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Payment History Modal -->
<div class="modal fade effect-scale modal-blur" id="paymenthistory" tabindex="-1" aria-labelledby="paymenthistoryLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="paymenthistoryLabel">
                    <i class="fas fa-history me-2"></i>Payment History
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Hidden Input -->
                <input type="hidden" id="rt_rent_id" value="0">
                
                <!-- Action Buttons -->
                <div class="d-flex justify-content-between mb-4">
                    <div>
                        <button class="btn btn-warning px-4" id="btn_load_payments">
                            <i class="fas fa-sync-alt me-2"></i>Load Payments
                        </button>
                    </div>
                    <div>
                        <button class="btn btn-success px-4" data-bs-toggle="collapse" data-bs-target="#addpaymentdiv">
                            <i class="fas fa-plus-circle me-2"></i>Add New Payment
                        </button>
                    </div>
                </div>
                
                <!-- Add Payment Form -->
                <div class="collapse mb-4" id="addpaymentdiv">
                    <div class="card">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0 text-primary">
                                <i class="fas fa-money-check-alt me-2"></i>Record New Payment
                            </h6>
                        </div>
                        <div class="card-body">
                            <form id="addPaymentForm" class="needs-validation" novalidate>
                                <div class="row g-3">
                                    <!-- Left Column -->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="py_payment_mode" class="form-label fw-semibold">
                                                <i class="fas fa-credit-card me-1"></i>Payment Mode <span class="text-danger">*</span>
                                            </label>
                                            <select class="form-select" id="py_payment_mode" required>
                                                <option value="" selected disabled>-- Select Payment Mode --</option>
                                                <option value="Cash">Cash</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="Bank Transfer">Bank Transfer</option>
                                                <option value="Mobile Money">Mobile Money</option>
                                                <option value="Online Payment">Online Payment</option>
                                            </select>
                                            <div class="invalid-feedback">Please select payment mode.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="receipt_no" class="form-label fw-semibold">
                                                <i class="fas fa-receipt me-1"></i>Receipt Number <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="receipt_no" required>
                                            <div class="invalid-feedback">Please enter receipt number.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="arrears_amount" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Arrears Amount (GHS) <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">GHS</span>
                                                <input type="number" class="form-control" id="arrears_amount" step="0.01" min="0" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter arrears amount.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="period_in_arrears" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-times me-1"></i>Periods in Arrears <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" id="period_in_arrears" min="0" required>
                                                <span class="input-group-text">periods</span>
                                            </div>
                                            <div class="invalid-feedback">Please enter periods in arrears.</div>
                                        </div>
                                    </div>
                                    
                                    <!-- Right Column -->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="payment_amount" class="form-label fw-semibold">
                                                <i class="fas fa-money-bill-wave me-1"></i>Payment Amount (GHS) <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">GHS</span>
                                                <input type="number" class="form-control" id="payment_amount" step="0.01" min="0" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter payment amount.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="last_payment_period" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-check me-1"></i>Last Payment Period <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="last_payment_period" placeholder="e.g., 2024-Q1" required>
                                            <div class="invalid-feedback">Please enter last payment period.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="payment_date" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-day me-1"></i>Payment Date <span class="text-danger">*</span>
                                            </label>
                                            <input type="date" class="form-control" id="payment_date" required>
                                            <div class="invalid-feedback">Please select payment date.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="payment_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment-dots me-1"></i>Remarks
                                            </label>
                                            <textarea class="form-control" id="payment_remarks" rows="3" placeholder="Optional notes about this payment..."></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Form Actions -->
                                <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                                    <button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="collapse" data-bs-target="#addpaymentdiv">
                                        <i class="fas fa-times me-1"></i> Cancel
                                    </button>
                                    <button type="submit" class="btn btn-success" id="btn_save_payment">
                                        <i class="fas fa-save me-1"></i> Save Payment
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Quick Stats -->
                    <div class="row mt-3">
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-money-bill-wave fa-2x text-success"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Current Balance</h6>
                                            <p class="mb-0 fw-bold text-success" id="currentBalance">GHS 0.00</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-clock fa-2x text-warning"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Last Payment</h6>
                                            <p class="mb-0 fw-bold" id="lastPaymentDate">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-calendar-alt fa-2x text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Period Status</h6>
                                            <p class="mb-0 fw-bold" id="periodStatus">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Payment History Table -->
                <div class="card border-warning">
                    <div class="card-header bg-warning bg-opacity-10 border-warning d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 text-warning">
                            <i class="fas fa-list-ol me-2"></i>Payment History Records
                        </h6>
                        <div>
                            <span class="badge bg-warning text-dark me-2" id="paymentCount">0 payments</span>
                            <span class="badge bg-success" id="totalPaid">GHS 0.00</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered align-middle mb-0" id="tbl_rent_payment_history" width="100%">
                                <thead class="table-light">
                                    <tr>
                                        <th width="80px" class="text-center">
                                            <i class="fas fa-cog"></i>
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-credit-card me-1"></i>Payment Mode
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-exclamation-triangle me-1"></i>Arrears Amount
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-receipt me-1"></i>Receipt No.
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-calendar-day me-1"></i>Date
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-money-bill-wave me-1"></i>Payment Amount
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-clipboard-check me-1"></i>Status
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-user-check me-1"></i>Recorded By
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="paymentHistoryBody">
                                    <!-- Data will be populated here -->
                                    <tr id="noPaymentData">
                                        <td colspan="8" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-history fa-2x mb-3"></i>
                                                <p class="mb-2 fw-semibold">No Payment History Available</p>
                                                <small>Click "Load Payments" to fetch payment records</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot class="table-light" id="paymentSummary" style="display: none;">
                                    <tr>
                                        <td colspan="5" class="text-end fw-bold">Total Paid Amount:</td>
                                        <td colspan="3" class="text-start fw-bold text-success" id="summaryTotalPaid">GHS 0.00</td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="text-end fw-bold">Total Payments:</td>
                                        <td colspan="3" class="text-start fw-bold text-primary" id="summaryPaymentCount">0 payments</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Filter and Export Options -->
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="paymentSearch" placeholder="Search payments...">
                                    <button class="btn btn-outline-secondary" type="button" id="clearSearch">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 text-end">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-primary btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                                        <i class="fas fa-download me-1"></i> Export
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#" id="exportPDF">
                                            <i class="fas fa-file-pdf text-danger me-2"></i> Export as PDF
                                        </a></li>
                                        <li><a class="dropdown-item" href="#" id="exportExcel">
                                            <i class="fas fa-file-excel text-success me-2"></i> Export as Excel
                                        </a></li>
                                        <li><a class="dropdown-item" href="#" id="exportCSV">
                                            <i class="fas fa-file-csv text-info me-2"></i> Export as CSV
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Statistics Summary -->
                <div class="row mt-4" id="paymentStatistics" style="display: none;">
                    <div class="col-md-3">
                        <div class="card bg-success bg-opacity-10 border-success">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-money-check-alt fa-2x text-success mb-2"></i>
                                <h5 class="mb-1" id="totalPaymentsCount">0</h5>
                                <small class="text-muted">Total Payments</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info bg-opacity-10 border-info">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-cash-register fa-2x text-info mb-2"></i>
                                <h5 class="mb-1" id="avgPaymentAmount">GHS 0.00</h5>
                                <small class="text-muted">Average Payment</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning bg-opacity-10 border-warning">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-calendar-minus fa-2x text-warning mb-2"></i>
                                <h5 class="mb-1" id="lastPaymentDays">-</h5>
                                <small class="text-muted">Days Since Last</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-primary bg-opacity-10 border-primary">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-chart-line fa-2x text-primary mb-2"></i>
                                <h5 class="mb-1" id="paymentFrequency">-</h5>
                                <small class="text-muted">Payment Frequency</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="recordInfo">No lease selected</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Single Rent Demand Notice Modal - Bootstrap 5 -->
<div class="modal fade effect-scale modal-blur" id="singlerentdemandnotice" tabindex="-1" aria-labelledby="singlerentdemandnoticeLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="singlerentdemandnoticeLabel">
                    <i class="fas fa-file-invoice-dollar me-2"></i>Single Rent Demand Notice
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Hidden Inputs -->
                <input type="hidden" id="rdn_rent_id" value="0">
                <input type="hidden" id="rdn_account_number" value="0">
				<input type="hidden" id="rdn_plot_number" value="0">
				<input type="hidden" id="rdn_estate" value="0">
                
                <!-- Lessee Information Card -->
                <div class="card mb-4">
                    <div class="card-header bg-primary bg-opacity-10">
                        <h6 class="mb-0 text-primary">
                            <i class="fas fa-user-circle me-2"></i>Lessee Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_leasee_name" class="form-label fw-semibold">
                                        <i class="fas fa-user me-1"></i>Full Name <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rdn_leasee_name" required>
                                    <div class="invalid-feedback">Please enter lessee name.</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_email" class="form-label fw-semibold">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-at"></i>
                                        </span>
                                        <input type="email" class="form-control" id="rdn_email">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="rdn_leasee_address" class="form-label fw-semibold">
                                        <i class="fas fa-map-marker-alt me-1"></i>Postal Address <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" id="rdn_leasee_address" rows="2" required></textarea>
                                    <div class="invalid-feedback">Please enter lessee address.</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_mobile_phone_1" class="form-label fw-semibold">
                                        <i class="fas fa-phone me-1"></i>Primary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-mobile-alt"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="rdn_mobile_phone_1">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_mobile_phone_2" class="form-label fw-semibold">
                                        <i class="fas fa-phone-alt me-1"></i>Secondary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-mobile"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="rdn_mobile_phone_2">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Action Button -->
                <div class="text-center mb-4">
                    <button class="btn btn-primary btn-lg px-5 py-2" id="btn_generate_rent_demand_note">
                        <i class="fas fa-cogs me-2"></i>Generate Rent Demand Notice
                    </button>
                    <div class="mt-2 text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Click to calculate rent assessment based on current rates
                    </div>
                </div>

                 <div class="text-center mb-4">
                    <button class="btn btn-primary btn-lg px-5 py-2" id="btn_generate_rent_demand_note_current_year">
                        <i class="fas fa-cogs me-2"></i>Generate Rent Demand Notice(Current Year)
                    </button>
                    <div class="mt-2 text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Click to calculate rent assessment based on current rates
                    </div>
                </div>
                
                <!-- Assessment Details Card -->
                <div class="card">
                    <div class="card-header bg-warning bg-opacity-10 d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 text-warning">
                            <i class="fas fa-calculator me-2"></i>Rent Assessment Details
                        </h6>
                        <span class="badge bg-warning text-dark" id="assessmentCount">0 items</span>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered align-middle mb-0" id="tbl_rent_assessment_details">
                                <thead class="table-light">
                                    <tr>
                                        <th>Period</th>
                                        <th>A-1Cedi</th>
                                        <th>A-1Cedi PA</th>
                                        <th>Annual Rent</th>
                                        <th>Amount Assessed </th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody id="assessmentTableBody">
                                    <!-- Data will be populated here -->
                                    <tr id="noAssessmentData">
                                        <td colspan="6" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-calculator fa-2x mb-3"></i>
                                                <p class="mb-0">No assessment data available.</p>
                                                <small>Click "Generate Rent Demand Notice" to calculate</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot class="table-light">
                                    <tr id="assessmentTotalRow" style="display: none;">
                                        <td colspan="3" class="text-end fw-bold">Total Amount Due:</td>
                                        <td colspan="3" class="text-start fw-bold text-success" id="totalAmountDue">GHS 0.00</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Summary Information -->
                        <div class="row mt-4" id="assessmentSummary" style="display: none;">
                            <div class="col-md-6">
                                <div class="alert alert-info py-2">
                                    <small>
                                        <i class="fas fa-info-circle me-1"></i>
                                        <strong>Generated:</strong> <span id="generationDate">-</span>
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="alert alert-warning py-2">
                                    <small>
                                        <i class="fas fa-clock me-1"></i>
                                        <strong>Assessment Period:</strong> <span id="assessmentPeriod">-</span>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Notes Section -->
                <div class="alert alert-light border mt-4">
                    <div class="d-flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-sticky-note text-primary"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <small class="text-muted">
                                <strong>Note:</strong> This demand notice is generated based on current rent rates and outstanding amounts. 
                                Please review all details before printing or sending to the lessee.
                            </small>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-warning me-2" id="btn_print_rent_demand_note" disabled>
                            <i class="fas fa-print me-1"></i> View & Print
                        </button>
                        <button type="button" class="btn btn-primary" id="btn_send_email" disabled>
                            <i class="fas fa-paper-plane me-1"></i> Send Email
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rent Transaction History Modal -->
<div class="modal fade modal-blur effect-scale" data-position="0" id="rentTransactionhistory" tabindex="-1" aria-labelledby="rentTransactionhistoryLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white" id="rentTransactionhistoryLabel">
                    <i class="fas fa-history me-2"></i>Transaction History
                </h5>
                <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <!-- Action Buttons Section -->
                <div class="bg-light px-4 py-3 border-bottom">
                    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-warning d-none" id="xloadRt" onclick="loadTransactionHistory()">
                                <i class="fas fa-redo me-2"></i>Reload
                            </button>
                            <button class="btn btn-outline-danger d-none" id="btnAddNewLessee" 
                                    data-bs-toggle="modal" data-bs-target="#addlegder">
                                <i class="fas fa-user-plus me-2"></i>Add New Lessee
                            </button>
                        </div>
                        <div>
                            <button class="btn btn-success px-4" id="btnAddTransaction">
                                <i class="fas fa-plus-circle me-2"></i>Add Transaction
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Hidden Inputs -->
                <div class="d-none">
                    <input id="rth_m_idxxx" type="hidden" />
                    <input id="rth_plot_numberxxx" type="hidden" />
                </div>
                
                <!-- Table Section -->
                <div class="p-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-bottom py-3">
                            <h6 class="mb-0 text-primary fw-semibold">
                                <i class="fas fa-table me-2"></i>Transaction Records
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" id="tbl_rent_transaction_history" 
                                       width="100%" cellspacing="0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-hashtag text-primary"></i>
                                                    <span>Plot Number</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-user text-primary"></i>
                                                    <span>Name of Lessee</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-file-contract text-primary"></i>
                                                    <span>Nature of Interest</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-calendar-alt text-primary"></i>
                                                    <span>Consent Date</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-clock text-primary"></i>
                                                    <span>Term</span>
                                                </div>
                                            </th>
                                            <th class="text-center pe-4">
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-cogs text-primary"></i>
                                                    <span>Actions</span>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="border-top-0">
                                        <!-- Data will be populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Empty State -->
                        <div class="text-center py-5 d-none" id="emptyTableState">
                            <div class="mb-3">
                                <i class="fas fa-inbox fa-3x text-muted opacity-25"></i>
                            </div>
                            <h5 class="text-muted mb-2">No Transactions Found</h5>
                            <p class="text-muted mb-4">Add your first transaction to get started</p>
                            <button class="btn btn-primary" id="btnAddTransactionEmpty">
                                <i class="fas fa-plus me-2"></i>Add First Transaction
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Showing <span id="recordCount">0</span> records
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Transaction Modal -->
<div class="modal fade effect-scale modal-blur" data-position="0" id="addtransactionModal" tabindex="-1" aria-labelledby="addtransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white" id="addtransactionModalLabel">
                    <i class="fas fa-plus-circle me-2"></i>Add New Transaction
                </h5>
                <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <div class="p-4">
                    <form id="transactionhistoryForm">
                        <input type="hidden" id="rht_is_edit" value="0"/>
                        <!-- Hidden Inputs -->
                        <div class="d-none">
                            <input id="rth_rent_id" value="0" type="hidden"/>
                            <input id="rth_m_id" value="0" type="hidden"/>
                            <input id="rth_account_number" value="0" type="hidden"/>
                        </div>
                        
                        <!-- Lessee's Details Card -->
                        <div class="card mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-success text-primary py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-user me-2"></i>Lessee's and Grantor's Details
                                </h6>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_lessee_name" 
                                                   placeholder="Full Name" required />
                                            <label for="rth_lessee_name">
                                                Name <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_lessee_address" 
                                                   placeholder="Complete Address" required />
                                            <label for="rth_lessee_address">
                                                Address <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="tel" class="form-control" id="rth_mobile_phone_1" 
                                                   placeholder="Primary Mobile Number" required />
                                            <label for="rth_mobile_phone_1">
                                                Mobile Phone <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="tel" class="form-control" id="rth_mobile_phone_2" 
                                                   placeholder="Secondary Mobile Number" />
                                            <label for="rth_mobile_phone_2">Mobile Phone 2</label>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-floating">
                                            <input type="email" class="form-control" id="rth_email" 
                                                   placeholder="Email Address" />
                                            <label for="rth_email">Email Address</label>
                                        </div>
                                    </div>
                                     <div class="col-6">
                                        <div class="form-floating">
                                            <input type="email" class="form-control" id="rth_grantor_name" 
                                                   placeholder="Email Address" />
                                            <label for="rth_grantor_name">Grantor's Name</label>
                                        </div>
                                    </div>

                                    
                                </div>
                            </div>
                        </div>
                        
                        <!-- Parcel's Details Card -->
                        <div class="card mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-success text-primary py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-map me-2"></i>Parcel's Details
                                </h6>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_plot_number" 
                                                   placeholder="Plot Number" required />
                                            <label for="rth_plot_number">
                                                Plot Number <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_plot_size" 
                                                   placeholder="Plot Size" required />
                                            <label for="rth_plot_size">
                                                Plot Size <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating">
                                            <select class="form-select" id="rth_nature_of_instrument" required>
                                                <option selected disabled value="">-- Select Nature of Instrument --</option>
                                                <c:forEach items="${nature_of_instrument_list}" var="natureofinstrumentlist">
                                                    <option value="${natureofinstrumentlist.nt_name}">${natureofinstrumentlist.nt_name}</option>
                                                </c:forEach>
                                            </select>
                                            <label for="rth_nature_of_instrument">
                                                Nature of Instrument <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating">
                                            <input type="date" class="form-control" id="rth_comm_date" 
                                                   placeholder="Commencement Date" required />
                                            <label for="rth_term">
                                                Commencement Date <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_term" 
                                                   placeholder="Term" required />
                                            <label for="rth_term">
                                                Term <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <div class="form-floating">
                                            <input type="date" class="form-control" id="rth_consent_date" 
                                                   placeholder="Consent Date" required />
                                            <label for="rth_term">
                                                Consent Date <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                   
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <textarea class="form-control" id="rth_remarks" 
                                                      placeholder="Additional Remarks" 
                                                      style="height: 100px"></textarea>
                                            <label for="rth_remarks">Remarks</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            
                        </div> -->
                    </form>
                </div>
            </div>
            
            <div class="modal-footer bg-light">
                <button class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
                <button type="submit" class="btn btn-success px-4 py-2" id="rth_save_btn">
                    <i class="fas fa-save me-2"></i>Save Details
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Rent Documents Modal -->
<div class="modal fade effect-scale modal-blur" id="rentdocuments" tabindex="-1" aria-labelledby="rentdocumentsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="rentdocumentsLabel">
                    <i class="fas fa-folder me-2"></i>Lease Documents
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Action Buttons -->
                <div class="d-flex gap-2 mb-4 flex-wrap">
                    <button class="btn btn-warning" id="btn_load_scanned_documents_rent">
                        <i class="fas fa-sync-alt me-2"></i>Load Documents
                    </button>
                    <button class="btn btn-primary rentFileUploadModal">
                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Document
                    </button>
                </div>
                <input type="hidden" id="file_upload_account_number_rent">
                <!-- Documents Table -->
                <div class="card">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                            <i class="fas fa-list me-2"></i>Document List
                        </h6>
                        <div>
                            <span class="badge bg-primary" id="documentCount_rent">0 documents</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="lc_rent_scanned_documents_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th class="text-start">
                                            <i class="fas fa-file me-1"></i>Document
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-tag me-1"></i>Type
                                        </th>
                                        <th class="text-center" style="width: 150px;">
                                            <i class="fas fa-cog me-1"></i>Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="lc_rent_scanned_documents_dataTable_body">
                                    <!-- Dynamic content will be loaded here -->
                                    <tr id="noDocumentsRow_rent">
                                        <td colspan="6" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-folder-open fa-2x mb-3"></i>
                                                <p class="mb-2 fw-semibold">No Documents Found</p>
                                                <small>Upload documents using the "Upload Document" button above</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="documentInfo">Documents are stored securely</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rent Remarks Modal -->
<div class="modal fade" data-position="0" id="rentremarks" tabindex="-1" aria-labelledby="rentremarksLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rentremarksLabel">Remarks</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2" onclick="loadTransactionRemarks()">Load Remarks</button>
				<button class="btn btn-success btn-sm mb-2" data-bs-toggle="collapse" data-bs-target="#addremarkdiv">Add Remark</button>
				<div class="collapse mb-2" id="addremarkdiv">
					<div class="card card-body">
						<form id="transactionremarksForm">
							<input id="rnt_id" type="hidden" value="0" />
							<input id="rnt_m_id" type="hidden" value="0" />
							<div class="mb-3">
								<label for="rnt_remarks" class="form-label">Remarks <span class="text-danger">*</span></label>
								<textarea class="form-control" id="rnt_remarks"></textarea>
								<button class="btn btn-primary btn-sm mt-2" id="submitRemark">Save</button>
							</div>
						</form>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_remarks" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Remarks</th>
								<th>Created By</th>
								<th>Date</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- File Upload Modal -->
<div class="modal fade" id="fileRentUploadModal" tabindex="-1" aria-labelledby="fileRentUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileRentUploadModalLabel">Upload New File</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_rent_data">
					<label for="fileUploadFormrentdata" class="form-label">File:</label>
					<input id="fileUploadFormrentdata" class="form-control" type="file" name="fileUploadFormrentdata" />
					<input type="button" id="btn_upload_rent_data_file" class="btn btn-primary mt-2" value="Click to upload">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
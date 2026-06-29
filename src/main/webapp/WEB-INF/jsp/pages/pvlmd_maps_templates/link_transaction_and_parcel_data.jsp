<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <input type="hidden" id="is_link_transaction_and_parcel_data" value="true" />

        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Link Transaction and Parcel Data</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Search transaction detail by job/reference number, plot parcel polygon by property/reference number, and link them visually.</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">PVLMD Plottings</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Link Transaction and Parcel Data</li>
                </ol>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-xl-6">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-primary text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-file-contract me-2"></i>Transaction Lookup</h5>
                    </div>
                    <div class="card-body">
                        <form class="mb-3" id="link_job_search_form">
                            <label class="form-label fw-semibold" for="pvlmd_search_transaction_by_text">Job / Transaction Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                <input id="pvlmd_search_transaction_by_text" class="form-control" placeholder="Enter job number or reference" autocomplete="off" />
                                <button class="btn btn-primary" type="button" id="pvlmd_btn_search_transaction"><i class="fas fa-search me-1"></i>Search</button>
                            </div>
                            <input type="hidden" class="form-control" id="link_txn_selected_id" />
                        </form>
                        <div class="alert alert-light border d-none" id="link_txn_search_status"></div>
                        <div class="table-responsive" style="max-height: 300px; overflow:auto;">
                            <table class="table table-sm table-hover align-middle mb-0" id="pvlmd_transaction_all_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>Reference</th>
                                        <th>Type</th>
                                        <th>Date</th>
                                        <th>Plaintiff</th>
                                        <th>Defendant</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-info text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2"></i>Selected Transaction</h5>
                    </div>
                    <div class="card-body">
                        <dl class="row mb-0">
                            <dt class="col-5 text-muted small">Job / Reference</dt>
                            <dd class="col-7" id="link_txn_summary_reference">-</dd>

                            <dt class="col-5 text-muted small">Instrument</dt>
                            <dd class="col-7" id="link_txn_summary_type">-</dd>

                            <dt class="col-5 text-muted small">Date</dt>
                            <dd class="col-7" id="link_txn_summary_date">-</dd>

                            <dt class="col-5 text-muted small">Plaintiff</dt>
                            <dd class="col-7" id="link_txn_summary_party1">-</dd>

                            <dt class="col-5 text-muted small">Defendant</dt>
                            <dd class="col-7" id="link_txn_summary_party2">-</dd>

                            <dt class="col-5 text-muted small">Notes</dt>
                            <dd class="col-7" id="link_txn_summary_remarks">-</dd>
                        </dl>
                    </div>
                </div>

                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-warning text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-map-marker-alt me-2"></i>Parcel Lookup</h5>
                    </div>
                    <div class="card-body">
                        <label class="form-label fw-semibold" for="pvlmd_search_by_text">Property / Reference</label>
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="fas fa-search-location"></i></span>
                            <input id="pvlmd_search_by_text" class="form-control" placeholder="Enter property or reference number" autocomplete="off" />
                            <button class="btn btn-warning" type="button" id="pvlmd_parcel_btn_search_by_reference_number"><i class="fas fa-map-pin me-1"></i>Plot</button>
                            <input type="hidden" class="form-control" id="link_parcel_reference" />
                        </div>
                        <dl class="row mb-0">
                            <dt class="col-5 text-muted small">Property #</dt>
                            <dd class="col-7" id="link_parcel_summary_property">-</dd>

                            <dt class="col-5 text-muted small">Reference #</dt>
                            <dd class="col-7" id="link_parcel_summary_reference">-</dd>

                            <dt class="col-5 text-muted small">Locality</dt>
                            <dd class="col-7" id="link_parcel_summary_locality">-</dd>

                            <dt class="col-5 text-muted small">Plotted By</dt>
                            <dd class="col-7" id="link_parcel_summary_plotted_by">-</dd>

                            <dt class="col-5 text-muted small">Date Plotted</dt>
                            <dd class="col-7" id="link_parcel_summary_date_plotted">-</dd>
                        </dl>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-gradient-success text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-link me-2"></i>Link Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <p class="mb-2 text-muted small">After selecting a transaction and parcel, click the button below to confirm their link.</p>
                            <!-- <div class="alert alert-secondary mb-3" id="link_summary_status">No linked records yet.</div> -->
                            <button type="button" class="btn btn-success w-100" id="pvlmd_btn_link_transaction_and_parcel" disabled><i class="fas fa-check-circle me-1"></i>Link Transaction & Parcel</button>
                        </div>
                        <div class="mt-3">
                            <div class="fw-semibold mb-2">Linked Pair</div>
                            <p class="mb-1"><strong>Transaction:</strong> <span id="linked_txn_reference">-</span></p>
                            <p class="mb-0"><strong>Parcel:</strong> <span id="linked_parcel_reference">-</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-6">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-success text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-map me-2"></i>Parcel Map Viewer</h5>
                    </div>
                    <div class="card-body">
                        <!-- <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <input class="form-control" id="pvlmd_x_coordinate_mak" placeholder="X Coordinate" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <input class="form-control" id="pvlmd_y_coordinate_mak" placeholder="Y Coordinate" />
                                </div>
                            </div>
                        </div> -->
                        <!-- <div class="row g-2 mb-3">
                            <div class="col-sm-4">
                                <button class="btn btn-outline-primary btn-sm w-100" id="pvlmd_btn_show_location"><i class="fas fa-location-arrow me-1"></i>Show Location</button>
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-outline-secondary btn-sm w-100" id="pvlmd_btn_visualise_coordinate"><i class="fas fa-draw-polygon me-1"></i>Visualise Coordinates</button>
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-outline-info btn-sm w-100" id="pvlmd_btn_visualise_search"><i class="fas fa-search me-1"></i>Visualise Search</button>
                            </div>
                        </div> -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-8">
                                <textarea class="form-control form-control-sm" id="pvlmd_bl_wkt_polygon" rows="2" placeholder="Enter WKT polygon"></textarea>
                            </div>
                            <div class="col-md-4 d-grid">
                                <button class="btn btn-outline-primary btn-sm w-100" id="pvlmd_btn_visualise_wkt"><i class="fas fa-map me-1"></i>Visualise WKT</button>
                            </div>
                        </div>
                        <div class="row g-3 mb-3 align-items-end">
                            <div class="col-sm-4">
                                <label class="form-label small text-muted">Scale</label>
                                <input class="form-control form-control-sm" id="pvlmd_scale_value_e" value="500" />
                            </div>
                            <div class="col-sm-4">
                                <label class="form-label small text-muted">Preset</label>
                                <select class="form-select form-select-sm" id="pvlmd_scale_value">
                                    <option value="500">1:500</option>
                                    <option value="1000">1:1,000</option>
                                    <option value="2500">1:2,500</option>
                                    <option value="5000">1:5,000</option>
                                    <option value="10000">1:10,000</option>
                                </select>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="pvlmd_lockmapscale" checked />
                                    <label class="form-check-label small" for="pvlmd_lockmapscale">Lock scale</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <button class="btn btn-primary btn-sm" id="pvlmd_btn_scale_zoom"><i class="fas fa-search-plus me-1"></i>Apply Scale</button>
                            </div>
                        </div>

                        <div class="border rounded mb-3" >
                            <div id="pvlmd-map" class="h-100 w-100"></div>
                        </div>

                        <div class="row g-2">
                            <div class="col-sm-6">
                                <button class="btn btn-outline-warning btn-sm w-100" id="pvlmd_btn_search_for_scanned_maps"><i class="fas fa-layer-group me-1"></i>Search Scanned Map</button>
                            </div>
                            <div class="col-sm-6">
                                <button class="btn btn-outline-success btn-sm w-100" id="pvlmd_btn_load_for_scanned_maps"><i class="fas fa-check-circle me-1"></i>Load Scanned Map</button>
                            </div>
                        </div>
                        <div class="mt-3">
                            <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-select form-select-sm">
                                <option value="-1">No Scanned Image</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-gradient-secondary text-white py-3">
                        <h5 class="mb-0 fw-semibold"><i class="fas fa-list me-2"></i>Multiple Parcels</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-sm" id="pvlmd_more_than_one_parcel_Table">
                                <thead class="table-light">
                                    <tr>
                                        <th>Ref Number</th>
                                        <th>NT No.</th>
                                        <th>Locality</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="pvlmdparcelinformation" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Parcel Information</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">Property Number</span><div id="pvlmd_property_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">Reference Number</span><div id="pvlmd_reference_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">NT Number</span><div id="pvlmd_nt_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">File Number</span><div id="pvlmd_file_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">Sheet Number</span><div id="pvlmd_sheet_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="mb-2"><span class="text-muted small">Locality</span><div id="pvlmd_locality" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-12">
                                <div class="mb-2"><span class="text-muted small">Plot Number</span><div id="pvlmd_plot_number" class="fw-semibold">-</div></div>
                            </div>
                            <div class="col-12">
                                <div class="mb-2"><span class="text-muted small">Remarks</span><div id="pvlmd_remarks" class="fw-semibold">-</div></div>
                            </div>
                            <input type="hidden" id="pvlmd_gid" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

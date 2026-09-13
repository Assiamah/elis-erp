# Short application review loading

Apply `short_review_lazy_loading.sql` to the PostgreSQL database used by
`elis-service-v4` before deploying the ERP changes. This is based on the original full script supplied in the second attachment and replaces the attached
`vas.select_review_digital_workflow_short(text)` function. No service Java change
is needed: the existing `/value_added_service/select_review_digital_workflow_short`
endpoint already forwards the JSON request to that function.

- Omitted `section` preserves the original full response for existing callers.
- `section: "initial"` skips related jobs, both payment collections and the full
  workflow tree/list. It returns the current milestone, active steps and objection
  counts. Parcel and transaction fields remain available because the included
  workflow modals depend on them.
- `section: "workflow"` reads the workflow tree without initializing a workflow,
  loading parcel geometry, transaction details or payment collections.

The ERP's session-bound `/short_review_section` route uses the same
`/value_added_service/select_review_digital_workflow_short` API for all ten
sidebar collections. Sections `jobs`, `parties`, `payments`, `minutes`, `records`,
`queries`, `encumbrances`, `links`, `objections` and `letters` return
`{success: true, data: [...]}` using the original SQL queries and filters.
These requests return before workflow initialization and unrelated queries.
The default full response retains all 37 original keys; empty collections are
normalized to arrays and the workflow tree is a JSON array rather than encoded text.
The original milestone relationship `a.ms_id_m = s.priority_value` is retained. Browser requests contain a page token and an allowlisted
section; application identifiers and the API key remain on the server. The
existing document load buttons remain in place. Map layers initialize on click.

Specific work requests retain `select_general_request_workflow`; that function
was not supplied, so its initial database response has not been reduced. Their
history button refreshes their own workflow, not the main application workflow.

Validation after applying the function in a test environment:

1. Open a GeneralWorkRequest with an ongoing step. Verify the current milestone,
   modal fields and approval controls; an objected application must remain blocked.
2. Verify there are no sidebar collection or map tile requests before clicking
   Load. Load and refresh each section; check empty results and retry after failure.
3. Open two applications in separate tabs and confirm each loads its own records.
4. Verify the Case Steps button on both general and specific work requests.
5. Compare a request without `section` with the original full response to check
   compatibility with other callers.

The SQL has not been executed against a live database in this workspace.

## Workflow modals on the short page

Apply the updated `short_review_lazy_loading.sql` before deploying this change.
It only replaces `vas.select_review_digital_workflow_short(text)`; it does not
replace `vas.select_review_digital_workflow(text)` or change the full ERP request.

Clicking a step's Details button on the short page now calls `/short_review_modal`
with its page token and modal ID. The server chooses the template and collection
keys from `src/main/resources/short-review-modals.json`; browser-supplied application
IDs, template paths and collection names are not accepted. `section: "modal"`
returns fresh parcel, transaction, job and approval fields plus only the collections
needed by that modal. It skips workflow initialization and workflow aggregation.
The response's `section` marker prevents an older SQL function from silently
returning the full dataset. Modal requests for specific work requests also use
this read-only application-data section; their workflow definitions remain unchanged.

The shared JSPs keep their existing modal elements on the initial page. Hydration
metadata marks server-rendered fields and collection containers. The loader updates
those containers before replaying the Details click, so existing Bootstrap handlers,
form controls and map elements remain attached. The conditional JSP filter only
applies to fragment requests. Each Details click refreshes the data; loading disables
the trigger, and failures leave a retry message without opening incomplete details.
The accordion Load/Refresh buttons remain independent.

When adding a modal or changing the JSP fields it consumes, keep
`short-review-modals.json` (template and collection dependencies) and
`short-review-fields.json` (the short page's scalar attribute aliases) in sync.
Keep `data-short-hydrate` keys unique within each modal, and mark conditional
collection containers outside the condition so empty-to-populated transitions work.

Local checks use dummy data; the SQL migration and an authenticated application
workflow still need validation against the deployed database and service.

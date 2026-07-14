# Simplicity First

- Take the minimal reading of a ticket or request.
  "Make X configurable" or "remove the hard-coding" means the smallest clear change, not a config system.
- Do not add config files, CLI flags, new types, or build wiring for a future case (multi-tenant, multi-backend) that does not exist yet.
  At one consumer, a plain well-commented constant beats an external config: it is simpler and self-documenting, and editing one line is acceptable.
  Record the deferred generalisation as a code-comment pointer to the ticket.
- Treat new flags, options, and alternative backends as suspect by default.
  Prefer deletion and one frozen path; optionality invites incomparable results and silent divergence.
- When offering options, lead with the simplest.
  Before building any machinery, confirm the desired level of simplicity.

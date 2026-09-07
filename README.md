**Goal**

Testing Floci for testing the services supported to mock the APIs.

**Stack Information**
- Version:
    - 1.5.13-compat

- Execution:
    - floci start --image floci/floci:1.5.13-compat

**Issues**

- Message:

          
        2026-06-12 07:48:57,653 ERROR [io.qua.ver.htt.run.QuarkusErrorHandler] HTTP Request to / failed, error id: 2ad74150-267f-45a1-a225-649c045ff693-6: java.lang.IllegalStateException: Missing EC2 image catalog resource: ec2/image-catalog.yaml
        

- Resoultion:
    
        Downgraded to image 1.5.13-compat and not using latest.


**To Do**
- Deploy the floci UI, otherwise we need to use the aws cli command or terraform commands to test the current resources.

**NOTE**
Latest flocci image has cloudfront support, so upgrade the flocci tag to latest


describe 'ProposalService', ->
  service = null
  httpBackend = null

  beforeEach module 'loomioApp'

  beforeEach ->
    inject ($httpBackend, ProposalService) ->
      service = ProposalService
      httpBackend = $httpBackend

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  #describe 'start', ->
    #eventResponse =
      #id: 1
      #sequence_id: 1
      #proposal:
        #discussion_id: 1
        #author:
          #id: 1
          #name: 'jimmy'
        #title: 'hi'
        #description: 'hello'

    #it 'posts the comment to the server', ->
